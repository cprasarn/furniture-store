require 'uuid'

class Address < ActiveRecord::Base
  self.table_name = 'address'
  self.primary_key = :id
  
  attr_accessible :street1, :street2, :city, :state, :zip_code

  validates_presence_of :street1, :city, :state, :zip_code
  validates_uniqueness_of :street1, :scope => [:street2, :zip_code]
    
  def == (other)
    (self.street1 == other.street1) and
    (self.street2 == other.street2 or ((self.street2.nil? or self.street2.empty?) and (other.street2.nil? or other.street2.empty?))) and
    (self.city == other.city) and
    (self.state == other.state) and
    (self.zip_code == other.zip_code)
  end
  
  def initialize(attributes=nil, options={})
    super
    self.create_date = Time.new
    self.status = Status::DORMANT
  end
  
  def save
    uuid = UUID.new
    self.id = uuid.generate
    self.status = Status::ACTIVE
    super
  end
  
  def is_empty(data)
    (data.nil? or data.empty?)
  end    
end
