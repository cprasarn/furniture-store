module LeadSources
  DELIVERY = 'DELIVERY'
  PICKUP_EVANSTON = 'EVANSTON'
  PICKUP_CERMAK = 'CERMAK'

  class LeadSource
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
    ff_option = LeadSource.new('FRENDS & FAMILY', 'Friends & Family')
    ads_option = LeadSource.new('ADS', 'Advertisement')
    email_option = LeadSource.new('EMAIL', 'Email')
    other_option = LeadSource.new('OTHER','Other')
    
    data = [ff_option, ads_option, email_option, other_option]
    return data
  end
    
  module_function :table
end