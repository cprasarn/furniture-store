module Status
  DELETED = 0
  ACTIVE = 1
  PENDING = 2
  PROCESSED = 3
  SUSPENDED = 4
  FAILED = 5 
  
  def table
    data = ['Deleted', 'Active', 'Pending', 'Processed', 'Suspended', 'Failed']
    return data
  end
  
  module_function :table
end