module Status
  DELETED = 0
  DORMANT = 1
  ACTIVE = 2
  INACTIVE = 4
  PENDING = 8
  PROCESSED = 16 
  SUSPENDED = 32
  FAILED = 64 

  class StatusObject
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
    
    data << StatusObject.new(Status::DELETED, 'Deleted')
    data << StatusObject.new(Status::DORMANT, 'Dormant')
    data << StatusObject.new(Status::ACTIVE, 'Active')
    data << StatusObject.new(Status::INACTIVE, 'Inactive')
    data << StatusObject.new(Status::PENDING, 'Pending')
    data << StatusObject.new(Status::PROCESSED, 'Processed')
    data << StatusObject.new(Status::SUSPENDED, 'Suspended')
    data << StatusObject.new(Status::FAILED, 'Failed')
    
    return data
  end
  
  def description(status)
    result = Array.new
    table = Status.table
    table.each {|s| result << s.option if s.key & status}
      
    result_string = result * ','
    return result_string
  end
  
  module_function :table, :description
end