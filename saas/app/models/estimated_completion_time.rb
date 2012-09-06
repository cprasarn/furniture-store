module EstimatedCompletionTime
  class EstimatedTime
    def initialize(key, value)
      @key = key
      @value = value
    end
    
    def key
      @key
    end
    
    def option
      @value
    end
  end
      
  def table
    four_weeks = EstimatedTime.new(4, '4 Weeks')
    six_weeks = EstimatedTime.new(6, '6 Weeks')
    seven_weeks = EstimatedTime.new(7, '7 Weeks')
    eight_weeks = EstimatedTime.new(8, '8 Weeks')
    ten_weeks = EstimatedTime.new(10, '10 Weeks')
    twelve_weeks = EstimatedTime.new(12, '12 Weeks')
     
    data = [four_weeks, six_weeks, seven_weeks, eight_weeks, ten_weeks, twelve_weeks]
    return data
  end
    
  module_function :table
end