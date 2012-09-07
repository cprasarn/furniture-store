require 'uuid'

class User < ActiveRecord::Base
  protect_from_forgery
  self.table_name = 'user'
  
  attr_accessible :name
  
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
