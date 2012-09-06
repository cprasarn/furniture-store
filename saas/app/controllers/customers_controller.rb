include Status

class CustomersController < ApplicationController
  respond_to :html, :json, :js
  
  def search
    conditions = Hash.new
    
    # Prepare searching conditions
    customer_name = params[:customer_name]
    if !( customer_name.nil? or customer_name.empty? )
      conditions['name LIKE ?'] = customer_name + '%'
    end
      
    home_phone = params[:home_phone]
    if !( home_phone.nil? or home_phone.empty? )
      conditions['home_phone = ?'] = home_phone
    end
    
    mobile_phone = params[:mobile_phone]
    if !( mobile_phone.nil? or mobile_phone.empty? )
      conditions['mobile_phone = ?'] = mobile_phone
    end
    
    business_phone = params[:business_phone]
    if !( business_phone.nil? or business_phone.empty? )
      conditions['business_phone = ?'] = business_phone
    end
        
    email = params[:email]
    if !( email.nil? or email.empty? )
      conditions['email = ?'] = email
    end
    
    # Execute query
    if 0 < conditions.length
      conditions_list = Array.new
      conditions_list << conditions.keys.join(' AND ')
      conditions.values.each {|v| conditions_list << v }
      @customers = Customer.find(:all, :conditions => conditions_list)
    end
    
    # Prepare response
    list = @customers.map { |o| Hash[id: o.id, label: o.name, name: o.name, data: o] }
    respond_to do |format|
      format.json { render json: list }
      format.html # search.html.erb
    end
  end
  
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.page(params[:page]).order(params[:sort])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])
    @status_table = Status.table
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.name.nil? or @customer.name.empty?
        @customer.errors.add(:name, "Please specify customer name")
      end
      
      if !@customer.errors.any?
        if @customer.save
          # Success
          format.html { redirect_to customers_path, notice: 'Customer was successfully created.' }
          format.json { render json: @customer, status: :created, location: @customer }
        else
          # Display error message
          format.html { render action: "new" }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      else
        # Display error message
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
end
