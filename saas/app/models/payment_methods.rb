module PaymentMethods
  CREDIT_CARD = 'Creadit Card'
  CASH = 'Cash'
  CHECK = 'Check'
  
  class PaymentMethod
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
    credit_card_option = PaymentMethod.new('CREDIT_CARD', 'Credit Card')
    cash_option = PaymentMethod.new('CASH', 'Cash')
    check_option = PaymentMethod.new('CHECK', 'Check')
    
    data = [credit_card_option, cash_option, check_option]
    return data
  end
    
  module_function :table  
end