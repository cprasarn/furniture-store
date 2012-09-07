require 'uuid'

class Address < ActiveRecord::Base
  self.table_name = 'address'
  self.primary_key = :id
  
  attr_accessible :street1, :street2, :city, :state, :zip_code

  validates :street1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip_code, :presence => true  
    
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
end
