
class LedgersController < ApplicationController
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
    @ledger = Ledger.new
    @ledger.order_number = params[:order_number]
    @ledger.payment_date = Date.strptime(params[:payment_date], "%m/%d/%Y")
    @ledger.payment_type = params[:payment_type]
    @ledger.payment_method = params[:payment_method]
    @ledger.amount = params[:amount]
    @ledger.status = params[:status]
      
    respond_to do |format|
      if @ledger.save
        format.html { render 'new_record' }
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

    respond_to do |format|
      if @ledger.update_attributes(params[:ledger])
        format.html { redirect_to @ledger, notice: 'Ledger was successfully updated.' }
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
end
