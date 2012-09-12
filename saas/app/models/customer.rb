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
  validates :email, :presence => true, :uniqueness => true
  validates_uniqueness_of :home_phone, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :mobile_phone, :allow_nil => true, :allow_blank => true
    
  def == (other)
    (self.name == other.name) and
    (self.home_phone == other.home_phone or ((self.home_phone.nil? or self.home_phone.empty?) and (other.home_phone.nil? or other.home_phone.empty?))) and
    (self.mobile_phone == other.mobile_phone or ((self.mobile_phone.nil? or self.mobile_phone.empty?) and (other.mobile_phone.nil? or other.mobile_phone.empty?))) and
    (self.business_phone == other.business_phone or ((self.business_phone.nil? or self.business_phone.empty?) and (other.business_phone.nil? or other.business_phone.empty?))) and
    (self.fax == other.fax or ((self.fax.nil? or self.fax.empty?) and (other.fax.nil? or other.fax.empty?))) and
    (self.email == other.email)
  end
  
  def self.not_empty(field)
    return !(field.nil? or field.empty?)
  end
  
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
