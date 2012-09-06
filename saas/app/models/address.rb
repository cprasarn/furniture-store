require 'uuid'

class Address < ActiveRecord::Base
  self.table_name = 'address'
  self.primary_key = :id
  
  attr_accessible :id, :street1, :street2, :city, :state, :zip_code,
    :create_date, :modify_date, :status

  validates :street1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip_code, :presence => true  
    
  def initialize(attributes=nil, options={})
    super
    self.create_date = Time.new
  end
  
  def save
    uuid = UUID.new
    self.id = uuid.generate
    super
  end    
end
