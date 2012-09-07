module EstimatedCompletionTime
  FOUR_WEEKS = 4
  SIX_WEEKS = 6
  SEVEN_WEEKS = 7
  EIGHT_WEEKS = 8
  TEN_WEEKS = 10
  TWELVE_WEEKS = 12
  
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
    data = Array.new
    
    data << EstimatedTime.new(EstimatedCompletionTime::FOUR_WEEKS, '4 Weeks')
    data << EstimatedTime.new(EstimatedCompletionTime::SIX_WEEKS, '6 Weeks')
    data << EstimatedTime.new(EstimatedCompletionTime::SEVEN_WEEKS, '7 Weeks')
    data << EstimatedTime.new(EstimatedCompletionTime::EIGHT_WEEKS, '8 Weeks')
    data << EstimatedTime.new(EstimatedCompletionTime::TEN_WEEKS, '10 Weeks')
    data << EstimatedTime.new(EstimatedCompletionTime::TWELVE_WEEKS, '12 Weeks')
     
    return data
  end
    
  module_function :table
end