
require 'uuid'

class Ledger < ActiveRecord::Base
  self.table_name = 'ledger'
  self.primary_key = :id
  self.per_page = 10
    
  attr_accessible :order_number, :payment_method, :payment_type, :amount, :payment_date, :status
  
  belongs_to :order, :foreign_key => 'order_number', :primary_key => 'order_number'
  
  validates_presence_of :order_number, :payment_method, :payment_type, :amount, :payment_date, :status
  
  def initialize(attributes=nil, options={})
    super
    self.payment_date = Time.new
    self.status = Status::DORMANT
  end
  
  def save
    uuid = UUID.new
    self.id = uuid.generate
    self.create_date = Time.new
    super
  end  
end
