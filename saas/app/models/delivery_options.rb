module DeliveryOptions
  DELIVERY = 'DELIVERY'
  PICKUP_EVANSTON = 'EVANSTON'
  PICKUP_CERMAK = 'CERMAK'

  class DeliveryOption
    def initialize(name, value)
      @name = name
      @value = value
    end
    
    def key
      @name
    end
    
    def option
      @value
    end
  end
      
  def table
    data = Array.new
    
    data << DeliveryOption.new('DELIVERY', 'Delivery')
    data << DeliveryOption.new('EVANSTON', 'Evanston Pickup')
    data << DeliveryOption.new('CERMAK', 'Cermak Pickup')
    
    return data
  end
    
  module_function :table
end