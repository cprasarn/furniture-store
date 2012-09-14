
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
    self.payment_date = Time.new if self.payment_date.nil?
    self.status = Status::DORMANT if self.status.nil?
  end
  
  def save
    self.create_date = Time.new
    if self.id.nil? or self.id.empty?
      uuid = UUID.new
      self.id = uuid.generate
    end
    super
  end
end
