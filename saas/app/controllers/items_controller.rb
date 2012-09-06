
class ItemsController < ApplicationController
  respond_to :html, :json, :js

  # GET /search
  def search
    # Support multiple search criteria
    conditions = Hash.new
    
    # By order number
    order_number = params[:order_number]
    if order_number
      conditions['order_number = ?'] = order_number
    end

    if ! conditions.empty?
      conditions_list = Array.new
      conditions_list << conditions.keys.join(' AND ')
      conditions.values.each {|v| conditions_list << v }  
      @items = Item.find(:all, :conditions => conditions_list)
    end
    
    respond_to do |format|
      format.json { render json: @items }
      format.html # search.html.erb
    end
  end
    
  # GET /items
  # GET /items.json
  def index
    sort_by = params[:sort]
    if sort_by.nil?
      sort_by = "create_date DESC"
    end
    @items = Item.page(params[:page]).order(sort_by)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    # Sketchup Mode
    @sketchup = params[:sketchup]
    
    @item = Item.new
    
    @order = Order.new
    @order.order_number = 'NEW ORDER'
    
    @customer = Customer.new
    @address = Address.new
    @address.state = 'IL'
    
    # Ledgers
    @deposit_ledger = Ledger.new
    @payment_ledger = Ledger.new
    
    # Options
    @state_list = State.order(:name)
    @delivery_option_list = DeliveryOptions.table
    @estimated_time_list = EstimatedCompletionTime.table
    @lead_source_list = LeadSources.table
    @payment_method_list = PaymentMethods.table
    
    # Output
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    # Item image file
    item_file_fields = params[:item][:image_file]
    if item_file_fields
      image_file = item_file_fields.tempfile
      params[:item][:image_file] = nil
    end
    
    # Parameters
    @sketchup = params[:sketchup]
    @store = params[:store]
    @item = Item.new(params[:item])
    @order = Order.new(params[:order])
    @customer = Customer.new(params[:customer])
    @address = Address.new(params[:address])
    
    @delivery_option_list = DeliveryOptions.table
    @lead_source_list = LeadSources.table

    # Check order number
    if ! @order.order_number.empty?
      # Existing order
      @item.order_number = @order.order_number
    end
    
    respond_to do |format|
      customer_id = @customer.id.to_i 
      if @item.order_number.empty? then
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
          if @customer != original_customer
            @customer.save
          end
        end
        
        # Order address ID
        if ! (@customer.errors.any?)
          address_id = @order.address_id
          if address_id.nil? or address_id.empty?
            # New address
            if (@address.id.nil? or @address.id.empty?) and @address.save then
              # Successfully created new address
              @order.address_id = @address.id
              
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
            if @address != original_address
              @address.id = nil  # Reset the address ID
              @address.save
              
              # Update customer primary address
              ca = CustomersAddress.get_by_customer_address(@customer.id, original_address.id)
              ca.update_attributes(:address_id => @address.id)
              
              # Order address
              @order.address_id = @address.id
            end
          end
        end
        
        # No errors found, so persist the order
        if ! (@order.errors.any? or @customer.errors.any? or @address.errors.any?) then
          if @order.save then
            @item.order_number = @order.order_number
          end
        end
      end
      
      if !@order.errors.any?
        @item.item_number = Item.next_item_number(@item.order_number)
        @item.image_uri = 'items/' + @item.item_name + '.png'
         
        if !( @item.order_number.nil? or @item.image_uri.nil? ) then
          if @item.save
            # Successfully persisted to the database
            @order = @item.order
            format.json { render json: @item }
            format.html { redirect_to @order }
          else
            format.html { render action: "new" }
            format.json { render json: @item.errors, status: :unprocessable_entity }
          end
        end
      else
        # Display error message
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @order = @item.order
    @item.destroy

    respond_to do |format|
      format.html { redirect_to @order }
      format.json { head :no_content }
    end
  end
end
