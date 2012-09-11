require 'uuid'

class Address < ActiveRecord::Base
  self.table_name = 'address'
  self.primary_key = :id
  
  attr_accessible :street1, :street2, :city, :state, :zip_code

  validates_presence_of :street1, :city, :state, :zip_code
  validates_uniqueness_of :street1, :scope => [:street2, :zip_code]
    
  def self.attributes_to_ignore_when_comparing
    [:id, :create_date, :modify_date, :status]
  end
  
  def identical?(other)
    self. attributes.except(*self.class.attributes_to_ignore_when_comparing.map(&:to_s)) ==
    other.attributes.except(*self.class.attributes_to_ignore_when_comparing.map(&:to_s))
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
