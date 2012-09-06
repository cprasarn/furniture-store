# == Schema Information
#
# Table name: orders_number
#
#  branch :string(50)      not null
#  code   :string(10)      not null
#  value  :integer(2)      not null
#

class OrderNumber < ActiveRecord::Base
  self.table_name = 'orders_number'
  
  attr_accessible :name, :code, :value

  def get_connection
    OrderNumber.establish_connection(
        :adapter  => "mysql2",
        :host     => "localhost",
        :username => "sketchup",
        :password => "sk3tchup",
        :database => "bookcase_dev",
        :autocomit => false
      )
  end
    
  def get_next(branch)
    sql = "CALL sp_order_number_next(\'" + branch + "\')"
    
    # Get a connection
    self.get_connection
    rs = connection.select_one(sql)

    if !rs.empty? then
      self.branch = rs['branch']
      self.code = rs['code']
      self.value = rs['value']
    end
    
    if !connection.active? then
      connection.reconnect!
    end    
  end
  
  def order_number
    time = Time.new
    result = self.code + time.strftime('%y') + '-' + sprintf('%04d', self.value)
    return result
  end
end
