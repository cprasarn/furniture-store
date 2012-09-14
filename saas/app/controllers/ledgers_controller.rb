
class LedgersController < ApplicationController
  respond_to :html, :json, :js
  before_filter :options, :only => [:new, :create, :edit, :update]
  
  # GET /ledgers
  # GET /ledgers.json
  def index
    @ledgers = Ledger.order(:payment_date)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ledgers }
    end
  end

  # GET /ledgers/1
  # GET /ledgers/1.json
  def show
    @ledger = Ledger.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ledger }
    end
  end

  # GET /ledgers/new
  # GET /ledgers/new.json
  def new
    @ledger = Ledger.new
    @payment_type_list = PaymentType.all
    @payment_method_list = PaymentMethods.table
    @status_list = Status.table
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ledger }
    end
  end

  # GET /ledgers/1/edit
  def edit
    @ledger = Ledger.find(params[:id])
  end

  # POST /ledgers
  # POST /ledgers.json
  def create
    @ledger = Ledger.new(params[:ledger])
    @ledger.payment_date = DateTime.strptime(params[:ledger][:payment_date], "%m/%d/%Y")
      
    respond_to do |format|
      if @ledger.save
        format.html { render 'ledger' }
        format.json { render json: @ledger, status: :created, location: @ledger }
      else
        format.html { render action: "new" }
        format.json { render json: @ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ledgers/1
  # PUT /ledgers/1.json
  def update
    @ledger = Ledger.find(params[:id])
    payment_date = DateTime.strptime(params[:ledger][:payment_date], "%m/%d/%Y")
    params[:ledger][:payment_date] = payment_date

    respond_to do |format|
      if @ledger.update_attributes(params[:ledger])
        @order = @ledger.order
        @ledgers = @order.ledgers
        @remaining_balance = @order.remaining_balance
        
        format.html { render 'list_form' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ledgers/1
  # DELETE /ledgers/1.json
  def destroy
    @ledger = Ledger.find(params[:id])
    @ledger.destroy

    respond_to do |format|
      format.html { redirect_to ledgers_url }
      format.json { head :no_content }
    end
  end

  protected
    def options
      # Options for select box
      @payment_type_list = PaymentType.order(:name)
      @payment_method_list = PaymentMethods.table
      @status_list = Status.table
    end    
end
