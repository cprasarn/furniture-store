class Shelves
  def initialize(groups)
    @groups = groups
  end  
        
  def change_description
    @groups.each {
      |g|
      if 'Space' != g.name then
        next
      end
            
      
      g.description = selected_description
    }
  end
end

def toggle_shelves_type
    ss = Sketchup.active_model.selection
    groups = ss.find_all { |e| e.kind_of?(Sketchup::Group) }
        
    if( groups.length < 1 )
        UI.messagebox($uStrings.GetString("You must at least one shelf"))
        return nil
    end

    shelves = Shelves.new(groups) 
    shelves.change_description()   
end

if( not file_loaded?("Shelves.rb") )
    UI.menu("Draw").add_item("Lipped Shelves") { toggle_shelves_type }
end

file_loaded("Shelves.rb")
