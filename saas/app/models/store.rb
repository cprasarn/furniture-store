# == Schema Information
#
# Table name: orders_number
#
#  branch :string(50)      not null
#  code   :string(10)      not null
#  value  :integer(2)      not null
#

class Store < ActiveRecord::Base
  self.table_name = 'stores'
  
  attr_accessible :name, :code, :store_number, :order_number, :image_directory,
    :street1, :street2, :city, :state, :zip_code, :phone, :fax

  def self.get_order_number(code, number)
    time = Time.new
    result = code + time.strftime('%y') + '-' + sprintf('%04d', number)
    return result    
  end
  
  def self.next_order_number(name)
    result = nil
    sql = "CALL sp_order_number_next('" + name + "')"
    
    begin
      connection = ActiveRecord::Base.connection
      if ! connection.active?
        connection.reconnect!
      end
      
      rs = connection.select_one(sql)
      if !rs.empty? then
        code = rs['code']
        number = rs['order_number']
        
        result = Store.get_order_number(code, number)
      end
      
      if !connection.active? then
        connection.reconnect!
      end      
    rescue NoMethodError
      
    end

    return result    
  end
  
  def self.get_image_directory(name)
    result = Store.where(name: name).first
    if !result.nil?
      return result.image_directory
    end
    
    return nil
  end
  
  def store_order_number
    return Store.get_order_number(self.code, self.order_number)
  end
end
