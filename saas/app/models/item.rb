# == Schema Information
#
# Table name: items
#
#  id             :string(128)     not null, primary key
#  order_number   :string(10)      not null
#  image_uri      :string(255)     not null
#  description    :string(255)
#  price          :float
#  finishing_cost :float
#  sales_tax      :float
#  create_date    :datetime        not null
#  status         :integer(1)      default(1), not null
#

require 'uuid'

class Item < ActiveRecord::Base
  self.table_name = 'items'
  self.per_page = 5
  IMAGE_PATH = 'app/assets/images'
  
  attr_accessible :order_number, :item_number, 
    :quantity, :wood, :finish, :description, :image_uri,  
    :price, :finishing_cost
  
  belongs_to :order, :foreign_key => 'order_number', :primary_key => 'order_number'
  
  attr_accessor :name, :image_file, :sketchup

  validates :order_number, :presence => true
  validates :item_number, :presence => true
  validates :quantity, :presence => true
  validates :description, :presence => true  
  validates :image_uri, :presence => true
  
  def initialize(attributes=nil, options={})
    super
    self.create_date = Time.new
    self.status = Status::DORMANT
  end
  
  def save
    uuid = UUID.new
    self.id = uuid.generate
    super
  end
  
  def item_name
    order_number + '_' + sprintf('%04d', item_number)
  end
  
  def save_image_file(temp_image_file)
    image_directory = Rails.root + Item::IMAGE_PATH
    if !File.directory?(image_directory)
      # Create the image directory
    end
    
    image_file = image_directory.to_s() + '/' + image_uri
    FileUtils.copy temp_image_file, image_file
  end
  
  def self.next_item_number(order_number)
    latest_item = Item.where(order_number: order_number).order('item_number DESC').first
    if latest_item.nil?
      result = 1
    else
      result = latest_item.item_number.to_i + 1
    end
    
    return result
  end
end
