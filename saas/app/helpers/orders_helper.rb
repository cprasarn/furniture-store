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
    # Item image file
    item_file_fields = (params.has_key?(:image_file) ? params[:image_file] : nil)
    temp_image_file = (item_file_fields.nil? ? nil : item_file_fields.tempfile)
    
    # Parameters
    store = (params.has_key?(:store) ? params[:store] : nil)
    if store.nil? or store.empty?
      store = 'HALSTED'
    end
         
    item = Item.new(params[:item])
      
    order = Order.new(params[:order])
    order.id = params[:order][:id]
    order.branch = store
        
    customer = Customer.new(params[:customer])
    customer.id = params[:customer][:id]
    order.customer_id = customer.id.to_i
      
    address = Address.new(params[:address])
    address.id = params[:address][:id]
    order.address_id = address.id

    # Customer
    customer = CustomersHelper.process(customer)
      
    # Address
    if !(customer.errors.any?)
      # Process order address information
      address = AddressesHelper.process(address, customer)
    end

    # Order
    if !(customer.errors.any? or address.errors.any?) then
      # Assign order address ID
      order.address_id = address.id

      # Assign order customer ID
      order.customer_id = customer.id
      
      # Process the order
      order = OrdersHelper.process(order)
    end

    # Item    
    if !(item.quantity.nil? or order.errors.any? or customer.errors.any? or address.errors.any?) then
      # Assign item order number
      item.order_number = order.order_number

      # Process new item
      item = ItemsHelper.process(item, temp_image_file)
    end
    
    return [order, customer, address, item]
  end
  
  def process(order)
    if order.id.nil? or order.id.empty?
      # Persist new order
      order.save
    else 
      # Existing order
      original_order = Order.find(order.id)
      if original_order != order
        # Save order history
        new_order = order.dup
        new_order.order_date = original_order.order_date
        new_order.save
        order = new_order
        
        original_order.status = Status::INACTIVE
        original_order.save!
      end
    end
    
    return order
  end
  
  module_function :browser_type, :process_order, :process
end
