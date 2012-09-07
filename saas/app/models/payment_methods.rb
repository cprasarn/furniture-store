module PaymentMethods
  CASH = 'CASH'
  CHECK = 'CHECK'
  CREDIT_CARD = 'CREDIT_CARD'
  
  class PaymentMethod
    def initialize(name, value)
      @name = name
      @value = value
    end
    
    def name
      @name
    end
    
    def description
      @value
    end
  end
      
  def table
    data = Array.new
    
    data << PaymentMethod.new(PaymentMethods::CASH, 'Cash')
    data << PaymentMethod.new(PaymentMethods::CHECK, 'Check')
    data << PaymentMethod.new(PaymentMethods::CREDIT_CARD, 'Credit Card')
    
    return data
  end
    
  module_function :table  
end