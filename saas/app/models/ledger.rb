
require 'uuid'

class Ledger < ActiveRecord::Base
  self.table_name = 'ledger'
  self.primary_key = :id
  self.per_page = 10
    
  attr_accessible :order_number, :payment_method, :payment_type, :amount
  
  belongs_to :order, :foreign_key => 'order_number', :primary_key => 'order_number'
  
  attr_accessor :name
  
  validates :order_number, :presence => true
  validates :payment_method, :presence => true
  validates :payment_type, :presence => true
  validates :amount, :presence => true
  
  def initialize(attributes=nil, options={})
    super
    self.payment_date = Time.new
    self.status = Status::DORMANT
  end
  
  def save
    uuid = UUID.new
    self.id = uuid.generate
    super
  end  
end
