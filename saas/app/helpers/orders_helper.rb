module OrdersHelper
  def lead_source
    return 'How did you hear about us?'
  end
  
  def browser_type(request, type)
    browser = request.env['HTTP_USER_AGENT']
    matches = /#{type}/.match(browser)
    return (matches.nil? ? false : type == matches[0])
  end

  def is_sketchup?
    OrdersHelper.browser_type(request, 'SketchUp')
  end

  def process_order(request, params)
    time = Time.new
    logger = Logger.new('order_helper.log')
    logger.debug '[BEGIN] ' + time.to_s

    # Item image file
    temp_image_file = nil
    item_file_fields = params[:image_file]
    if item_file_fields
      temp_image_file = item_file_fields.tempfile
    end
    
    # Parameters
    @store = params[:store]
    if @store.nil? or @store.empty?
      @store = 'HALSTED'
    end
    
    @item = Item.new(params[:item])
      
    @order = Order.new(params[:order])
    @order.id = params[:order][:id]
    @order.branch = @store
    if 'NEW ORDER' == @order.order_number
      @item.order_number = nil 
    else
      @item.order_number = @order.order_number
    end      
        
    @customer = Customer.new(params[:customer])
    @customer.id = params[:customer][:id]
    @order.customer_id = @customer.id.to_i
      
    @address = Address.new(params[:address])
    @address.id = params[:address][:id]
    @order.address_id = @address.id

    # Check browser type for SketchUp
    @sketchup = OrdersHelper.browser_type(request, 'SketchUp') 
        
    customer_id = @customer.id.to_i
    if @item.order_number.nil? or @item.order_number.empty?
      # New order  
      # Check the order customer ID
      if 0 == customer_id
        # New customer
        if @customer.save then
          # Successfully create a new customer
          @order.customer_id = @customer.id               
        end
      else
        # Existing customer, if there is any change to the customer detail,
        # persist the changes
        original_customer = Customer.find(@customer.id)
        logger.debug '[original_customer] ' + original_customer.attributes.to_s
        logger.debug '[customer] ' + @customer.attributes.to_s
        if !(original_customer.identical? @customer)
          @customer.save
        end
      end
      
      # Order address ID
      if !(@customer.errors.any?)
        address_id = @order.address_id
        if address_id.nil? or address_id.empty?
          logger.debug '[address] ' + @address.attributes.to_s
          # New address
          if (@address.id.nil? or @address.id.empty?) and @address.save then
            # Get the current primary address
            current_primary_address = CustomersAddress.get_primary(customer_id)
            if !current_primary_address.nil? 
              current_primary_address.update_attributes(:is_primary => 0) 
            end
            
            # Save customer address
            ca = CustomersAddress.new
            ca.customer_id = customer_id
            ca.address_id = @address.id
            ca.is_primary = 1 # new primary address
            ca.save
          end
        else
          # Existing address; in case there is any changes/updates to the address.
          # Persist new address and change the customer default address
          original_address = Address.find(@address.id)
          logger.debug '[original_address] ' + original_address.to_s
          logger.debug '[address] ' + @address.to_s
          if ! (original_address.identical? @address)
            @address.id = nil  # Reset the address ID
            @address.save
            
            # Update customer primary address
            ca = CustomersAddress.get_by_customer_address(@customer.id, original_address.id)
            ca.update_attributes(:address_id => @address.id)
          end
        end

        # Order address
        @order.address_id = @address.id
      end
      
      # No errors found, so persist the order
      if ! (@order.errors.any? or @customer.errors.any? or @address.errors.any?) then
        @order.customer_id = @customer.id
        logger.debug '[order] ' + @order.attributes.to_s
        if @order.id.nil? or @order.id.empty?
          # New order
          if @order.save
            @item.order_number = @order.order_number
          end 
        else 
          # Existing order
          original_order = Order.find(@order.id)
          if !(original_order.identical? @order)
            # Save order history
            @new_order = @order.dup
            @new_order.save
            @order = @new_order
            
            original_order.status = Status::INACTIVE
            original_order.save
          end
        end
      end
    end
    
    if ! (@order.errors.any? or @customer.errors.any? or @address.errors.any?) then
      @item.item_number = Item.next_item_number(@item.order_number)
      @item.image_uri = 'items/' + @item.item_name + '.png'
      if temp_image_file
        # Move the temporary file to local repository
        @item.save_image_file(temp_image_file.path)
      end
       
      @item.save
    end
    
    return [@order, @customer, @address, @item]
  end
  
  module_function :browser_type, :process_order
end
