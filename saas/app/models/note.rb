require 'uuid'
require 'note_type.rb'

class Note < ActiveRecord::Base
  self.table_name = 'note'
  attr_accessible :order_number, :item_number, :note_type, :content 
  
  belongs_to :order, :primary_key => 'order_number', :foreign_key => 'order_number'

  validates_presence_of :order_number, :note_type, :content
  
  def initialize(attributes=nil, options={})
    super
    self.note_type = NoteTypes::ORDER
    self.create_date = Time.new
    self.status = Status::DORMANT
  end
  
  def save
    uuid = UUID.new
    self.id = uuid.generate
    self.modify_date = Time.new
    
    super
  end
    
end
