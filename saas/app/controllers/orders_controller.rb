include DeliveryOptions
include LeadSources
include Status

class OrdersController < ApplicationController
  respond_to :html, :json, :js
  before_filter :options, :only => [:new, :create, :edit, :update]
  
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
      conditions['status <> ?'] = Status::INACTIVE
        
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
    status_condition = 'status <> ' + Status::INACTIVE.to_s
    @orders = Order.where(status_condition).page(params[:page]).order(:order_number)

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

  def is_sketchup
    OrdersHelper.browser_type(request, 'SketchUp')
  end
  
  # GET /orders/new
  # GET /orders/new.json
  def new
    @item = Item.new
    
    @order = Order.new
    @order.order_number = 'NEW ORDER'
    
    @customer = Customer.new
    @address = Address.new
    @address.state = 'IL'
    
    # Ledgers
    @deposit_ledger = Ledger.new
    @payment_ledger = Ledger.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @customer = @order.customer
    @address = @order.address
    @items = @order.items
    @ledgers = @order.ledgers
    
    @item = Item.new
  end

  # POST /orders
  # POST /orders.json
  def create
    respond_to do |format|
      result = OrdersHelper.process_order(request, params)
      @order = result[0]
      @customer = result[1]
      @address = result[2]
      @item = result[3]
      
      if !(@order.errors.any? or @customer.errors.any? or @address.errors.any? or @item.errors.any?) then
        format.json { render json: @item }
        format.html { redirect_to @order }
      else
        # Display error message
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    respond_to do |format|
      result = OrdersHelper.process_order(request, params)
      @order = result[0]
      @customer = result[1]
      @address = result[2]
      @item = result[3]

      if !(@order.errors.any? or @customer.errors.any? or @address.errors.any? or @item.errors.any?) then
        format.json { render json: @item }
        format.html { redirect_to @order }
      else
        # Display error message
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
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
  
  protected
    def options
      # Options for select box
      @state_list = State.order(:name)
      @delivery_option_list = DeliveryOptions.table
      @estimated_time_list = EstimatedCompletionTime.table
      @lead_source_list = LeadSources.table
      @payment_method_list = PaymentMethods.table
    end
end
