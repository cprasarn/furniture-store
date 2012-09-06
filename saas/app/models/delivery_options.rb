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
    delivery_option = DeliveryOption.new('DELIVERY', 'Delivery')
    evanston_option = DeliveryOption.new('EVANSTON', 'Evanston Pickup')
    cermak_option = DeliveryOption.new('CERMAK', 'Cermak Pickup')
    
    data = [delivery_option, evanston_option, cermak_option]
    return data
  end
    
  module_function :table
end