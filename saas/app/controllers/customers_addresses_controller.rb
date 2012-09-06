
class CustomersAddressesController < ApplicationController
  
  # GET /search
  def search
    conditions = Hash.new
    
    customer_id = params[:customer_id]
    if customer_id
      conditions['customer_id = ?'] = customer_id
    end
    
    is_primary = params[:is_primary]
    if is_primary
      conditions['is_primary = ?'] = is_primary
    end
    
    if !conditions.empty?
      conditions_list = Array.new
      conditions_list << conditions.keys.join(' AND ')
      conditions.values.each {|v| conditions_list << v }  
      @ca_list = CustomersAddress.find(:all, :conditions => conditions_list)      
    end

    # Output
    list = @ca_list.map {|o| Hash[id: o.id, label: o.customer_id, name: o.address_id, data: o]}
    respond_to do |format|
      format.json { render json: list }
      format.html # search.html.erb
    end
  end
  
  # GET /customers_addresses
  # GET /customers_addresses.json
  def index
    @customers_addresses = CustomersAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers_addresses }
    end
  end

  # GET /customers_addresses/1
  # GET /customers_addresses/1.json
  def show
    @customers_address = CustomersAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customers_address }
    end
  end

  # GET /customers_addresses/new
  # GET /customers_addresses/new.json
  def new
    @customers_address = CustomersAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customers_address }
    end
  end

  # GET /customers_addresses/1/edit
  def edit
    @customers_address = CustomersAddress.find(params[:id])
  end

  # POST /customers_addresses
  # POST /customers_addresses.json
  def create
    @customers_address = CustomersAddress.new(params[:customers_address])

    respond_to do |format|
      if @customers_address.save
        format.html { redirect_to @customers_address, notice: 'Customers address was successfully created.' }
        format.json { render json: @customers_address, status: :created, location: @customers_address }
      else
        format.html { render action: "new" }
        format.json { render json: @customers_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers_addresses/1
  # PUT /customers_addresses/1.json
  def update
    @customers_address = CustomersAddress.find(params[:id])

    respond_to do |format|
      if @customers_address.update_attributes(params[:customers_address])
        format.html { redirect_to @customers_address, notice: 'Customers address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customers_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers_addresses/1
  # DELETE /customers_addresses/1.json
  def destroy
    @customers_address = CustomersAddress.find(params[:id])
    @customers_address.destroy

    respond_to do |format|
      format.html { redirect_to customers_addresses_url }
      format.json { head :no_content }
    end
  end
end
