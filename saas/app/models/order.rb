# == Schema Information
#
# Table name: orders
#
#  id              :string(128)     not null, primary key
#  order_number    :string(10)      not null
#  customer_id     :integer(3)      not null
#  lead_source     :string(255)
#  delivery_option :string(80)
#  price           :float
#  finishing_cost  :float
#  delivery_charge :float
#  sales_tax       :float
#  payment_method  :string(20)
#  deposit         :float
#  balance         :float
#  order_date      :datetime        not null
#  due_date        :date
#  delivery_date   :date
#  status          :integer(1)      default(1), not null
#

require 'uuid'
require 'order_number.rb'

class Order < ActiveRecord::Base
  include Status
  
  self.table_name = 'orders'
  self.primary_key = :id
  self.per_page = 10
    
  attr_accessible :order_number, :customer_id, :address_id, :lead_source, 
    :price, :discount, :sales_tax, :finishing, 
    :delivery_option, :delivery_charge, 
    :order_date, :estimated_time, :delivery_date
   
  attr_accessor :branch, :subtotal, :total, :balance
  
  belongs_to :customer, :primary_key => 'id', :foreign_key => 'customer_id'
  has_one :address, :primary_key => 'id', :foreign_key => 'address_id'
  has_many :items, :primary_key => 'order_number', :foreign_key => 'order_number'
  has_many :ledgers, :primary_key => 'order_number', :foreign_key => 'order_number'
  
  validates :order_number, :presence => true
  validates :customer_id, :presence => true
  validates :address_id, :presence => true
  validates :price, :presence => true
  validates_associated :address 
     
  def initialize(attributes=nil, options={})
    super
    self.order_date = Time.new
    self.branch = 'HALSTED'
    self.status = Status::DORMANT
  end
  
  def save
    uuid = UUID.new
    self.id = uuid.generate
    
    self.order_number = Store.next_order_number(self.branch)
    super
  end
  
  def label
    self.order_number
  end
  
  def name
    self.order_number
  end
  
  def subtotal
    self.price.to_f + self.sales_tax.to_f
  end
  
  def total
    self.subtotal + self.finishing.to_f + self.delivery_charge.to_f
  end
end
