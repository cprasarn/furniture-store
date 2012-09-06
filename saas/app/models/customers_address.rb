require 'uuid'

class CustomersAddress < ActiveRecord::Base
  self.table_name = 'customers_address'
  self.primary_key = :id
  
  attr_accessible :id, :address_id, :customer_id, :is_primary, :create_date, :modify_date, :status
  
  belongs_to :customer
  has_one :address, :primary_key => 'address_id', :foreign_key => 'id'
  
  validates :customer_id, :presence => true
  validates :address_id, :presence => true
  
  def save
    uuid = UUID.new
    self.id = uuid.generate
    
    self.create_date = Time.new if self.create_date.nil?
    self.modify_date = Time.new
    super
  end
  
  # Get primary address for a customer
  def self.get_primary(customer_id)
    CustomersAddress.find(:all, :conditions => ['customer_id = ? AND is_primary = 1', customer_id]).first
  end
  
  # Get by customer ID and address ID
  def self.get_by_customer_address(customer_id, address_id)
    CustomersAddress.find(:all, :conditions => ['customer_id = ? AND address_id = ?', customer_id, address_id])
  end
end
