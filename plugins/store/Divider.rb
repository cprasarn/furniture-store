class Divider
  def initialize(groups)
    @groups = groups
    @top_face = nil
    @top_pt = nil
    @bottom_face = nil
    @bottom_pt = nil
    @thickness = 0.875
  end  
    
  def find_top
    g = @groups[0]
    entities = g.entities 
    faces = entities.find_all {|f| f.kind_of?(Sketchup::Face)}
    max_area = max_z = 100
    faces.each {
      |f|
      face_area = f.area
      if max_area <= face_area then 
        max_area = face_area
      else
        next
      end
        
      face_pt = f.bounds.center
      if max_z >= face_pt.z then
        max_z = face_pt.z
      else
        next
      end
        
      if nil == @top_pt then
        @top_pt = face_pt
        @top_face = f
      end
                
      distance = @top_pt.distance face_pt
      if 0 < distance then
        @top_pt = face_pt
        @top_face = f
      end
    }
  end
    
  def find_bottom
    g = @groups[1]
    entities = g.entities 
    faces = entities.find_all {|f| f.kind_of?(Sketchup::Face)}
    max_area = 0
    min_z = 0
    faces.each {
      |f|
      face_area = f.area
      if max_area <= face_area then 
        max_area = face_area
      else
        next
      end
        
      face_pt = f.bounds.center
      if min_z <= face_pt.z then
        min_z = face_pt.z
      else
        next
      end

      if nil == @bottom_pt
        @bottom_pt = face_pt
      end
                
      distance = @bottom_pt.distance face_pt
      if (0 < distance.abs)
        @bottom_pt = face_pt
      end
    }
  end

  def draw_panel(name, pt1, pt2, pt3, pt4, thickness)
    # Get handles to our model and the Entities collection it contains.
    model = Sketchup.active_model
    entities = model.entities
  
    # Group
    group = entities.add_group
    group.name = name
    group_entities = group.entities
  
    # Call methods on the Entities collection to draw stuff.
    new_face = group_entities.add_face pt1, pt2, pt3, pt4
    new_face.pushpull thickness, true
  end
  
  def draw
    find_top
    find_bottom
        
    height = @top_pt.z - @bottom_pt.z  
    x1 = @bottom_pt.x.to_f() - (@thickness / 2)
    x2 = @bottom_pt.x.to_f() + (@thickness / 2)
    y1 = 0
    y2 = @bottom_pt.y * 2
    z = @bottom_pt.z

    pt1 = [x1, y1, z]
    pt2 = [x2, y1, z]
    pt3 = [x2, y2, z]
    pt4 = [x1, y2, z]

    draw_panel 'Divider', pt1, pt2, pt3, pt4, height
  end
end

def draw_divider
    ss = Sketchup.active_model.selection
        
    # Get an Array of all of the selected Groups
    groups = ss.find_all { |e| e.kind_of?(Sketchup::Group) }
        
    # We need at least two groups
    if( groups.length < 2 )
        UI.messagebox($uStrings.GetString("Please select top and bottom shelves for the divider"))
        return nil
    end

    divider = Divider.new(groups) 
    divider.draw()   
end

#divider_tool = Divider.new
#Sketchup.active_model.select_tool divider_tool

if( not file_loaded?("Divider.rb") )
    UI.menu("Plugins").add_item("Center Divider") { draw_divider }
end

file_loaded("Divider.rb")
