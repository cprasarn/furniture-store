require 'Status.rb'

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

  # GET /search
  def list
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
    @item = Item.new
    
    order_number = params[:order_number]
    @order = (order_number.nil? ? Order.new : Order.by_order_number(order_number))
    if @order.new_record?
      @order.order_number = 'NEW ORDER' 
      @customer = Customer.new
      @address = Address.new
      @address.state = 'IL'
    else
      @customer = @order.customer
      @address = @order.address
      @items = @order.items
      @ledgers = @order.ledgers
    end    
    
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
    # Options
    @state_list = State.order(:name)
    @delivery_option_list = DeliveryOptions.table
    @estimated_time_list = EstimatedCompletionTime.table
    @lead_source_list = LeadSources.table
    @payment_method_list = PaymentMethods.table
    
    respond_to do |format|
      result = OrdersHelper.process_order(request, params)
      @order = result[0]
      @customer = result[1]
      @address = result[2]
      @item = result[3]

      if ! (@order.errors.any? or @customer.errors.any? or @address.errors.any? or @item.errors.any?) then
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
