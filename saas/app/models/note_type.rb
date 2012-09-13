module NoteTypes
  ORDER = 'ORDER'
  ITEM = 'ITEM'

  class NoteType
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
    
    data << NoteType.new(NoteTypes::ORDER, 'Order')
    data << NoteType.new(NoteTypes::ITEM, 'Item')
        
    return data
  end
    
  module_function :table
end