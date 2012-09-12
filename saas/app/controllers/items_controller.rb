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
    # Sketchup Mode
    @sketchup = OrdersHelper.browser_type(request, 'SketchUp')
    
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
    OrdersHelper.process_order(request, params)
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
