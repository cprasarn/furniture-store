include DeliveryOptions
include LeadSources

class OrdersController < ApplicationController
  respond_to :html, :json, :js
  
  # GET /search
  def search
    # Support multiple search criteria
    conditions = Hash.new
    
    # By order number
    order_number = params[:order_number]
    if order_number
      conditions['order_number LIKE ?'] = order_number + '%'
    end

    # By order date
    order_date = params[:order_date]
    if order_number.empty? and order_date
      order_date = Date.strptime(params[:order_date], "%m/%d/%Y")
      conditions['order_date LIKE ?'] = order_date.strftime('%Y-%m-%d ') + '%'
    end
    
    # By customer ID
    customer_id = params[:customer_id]
    if 0 < customer_id.to_i
      conditions['customer_id = ?'] = customer_id.to_i
    end
    
    # If there is any search criteria specified, performs a search
    if ! conditions.empty?
      conditions_list = Array.new
      conditions_list << conditions.keys.join(' AND ')
      conditions.values.each {|v| conditions_list << v }  
      @orders = Order.find(:all, :conditions => conditions_list)
    end
    
    # Output
    list = @orders.map {|o| Hash[id: o.order_number, label: o.order_number, name: o.order_number, data: o]}
    respond_to do |format|
      format.json { render json: list }
      format.html # search.html.erb
    end
  end
  
  # GET /orders
  # GET /orders.json
  def index
    # params[:sort]
    @orders = Order.page(params[:page]).order(:order_number)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
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
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      # Check order customer ID
      if 0 == @order.customer_id.to_i
        # Customer
        if @customer.name.nil? or @customer.name.empty? then
          @customer.errors.add(:name, "Please specify customer name")
        elsif @customer.save
          @order.customer_id = @customer.id
        end
      end
                
      if (!@order.errors.any?) && (!@customer.errors.any?) then
        if @order.save
          format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
          format.json { render json: @order, status: :created, location: @order }
        else
          format.html { render action: "new" }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      else
        # Display error message
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
   
    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
