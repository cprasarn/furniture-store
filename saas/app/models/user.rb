require 'uuid'

class User < ActiveRecord::Base
  protect_from_forgery
  self.table_name = 'user'
  
  attr_accessible :id, :name, :create_date, :modify_date, :status
  
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
