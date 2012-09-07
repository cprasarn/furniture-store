# == Schema Information
#
# Table name: customers
#
#  id             :integer(3)      not null, primary key
#  name           :string(80)      not null
#  home_phone     :string(20)
#  mobile_phone   :string(20)
#  business_phone :string(20)
#  fax            :string(20)
#  email          :string(80)
#  create_date    :datetime        not null
#  modify_date    :datetime
#  status         :integer(1)      default(1), not null
#

class Customer < ActiveRecord::Base
  self.table_name = 'customers'
  self.primary_key = :id
  self.per_page = 10
  
  attr_accessible :name, :home_phone, :mobile_phone, :business_phone, :fax, :email
  
  has_many :orders

  validates :name, :length => { :maximum => 80 }, :presence => true
  validates :home_phone, :uniqueness => true
  validates :mobile_phone, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  
  def initialize(attributes=nil, options={})
    super
    self.create_date = Time.new
    self.status = Status::DORMANT
  end
  
  def save
    self.modify_date = Time.new
    self.status = Status::ACTIVE
    super
  end
end
