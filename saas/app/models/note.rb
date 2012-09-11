class Note < ActiveRecord::Base
  attr_accessible :content, :note_type, :order_number
end
