require '57th/data/Status.rb'

class Order < ActiveRecord::Base
  attr_accessible :id, :order_number, :customer_id, 
    :lead_source, :delivery_option, 
    :price, :finishing_cost, :delivery_charge, :sales_tax,
    :deposit, :payment_method, :balance, 
    :order_date, :due_date, :delivery_date, :status
  
  def initialize
    self.id = 0
    self.order_number = nil
    self.customer_id = 0
    self.lead_source = nil
    self.delivery_option = nil
    self.price = 0.0
    self.finishing_cost = 0.0
    self.delivery_charge = 0.0
    self.sales_tax = 0.0
    self.payment_method = nil
    self.deposit = 0.0
    self.balance = 0.0
    self.order_date = nil
    self.due_date = nil
    self.delivery_date = nil
    self.status = Status::ACTIVE
  end 
end
