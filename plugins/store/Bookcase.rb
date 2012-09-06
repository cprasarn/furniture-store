class Bookcase
    def initialize(spaces, width, depth)
        @spaces = spaces - 1
        @width = width
        @depth = depth
        @thickness = 1
        
        case spaces
          when 2
            @height = 29.25
          when 3
            @height = 41
          when 4
            @height = 52.75
          when 5
            @height = 64.5
          when 6
            @height = 76.25
          when 7
            @height = 88
        end
    end

    def draw_panel(name, pt1, pt2, pt3, pt4, thickness)
      # Get handles to our model and the Entities collection it contains.
      model = Sketchup.active_model
      entities = model.entities

      # Group
      group = entities.add_group
      group.name = name
      group.description = 'Fixed'
      group_entities = group.entities
      
      # Call methods on the Entities collection to draw stuff.
      new_face = group_entities.add_face pt1, pt2, pt3, pt4
      new_face.pushpull thickness, true
    end

    def draw()
      # Top
      x1 = @thickness
      x2 = @width - @thickness
      y1 = 0
      y2 = @depth - @thickness
      z = @height

      pt1 = [x1, y1, z]
      pt2 = [x2, y1, z]
      pt3 = [x2, y2, z]
      pt4 = [x1, y2, z]

      draw_panel 'Top', pt1, pt2, pt3, pt4, @thickness

      # Spaces
      draw_spaces()

      # Bottom
      z = @thickness
      pt1 = [x1, y1, z]
      pt2 = [x2, y1, z]
      pt3 = [x2, y2, z]
      pt4 = [x1, y2, z]

      draw_panel 'Bottom', pt1, pt2, pt3, pt4, @thickness
           
      # Sides
      draw_sides()
    end

    def draw_spaces()
        height = @thickness
        thickness = 0.875
        
        # Loop across the same code several times
        for step in 1..@spaces
            case step
            when 1
                rise = 13 + (1 - thickness)
            when 2
                rise = 12
            else
                rise = 11
            end
            
            height += rise
            height += thickness
            
            # Calculate our space corners.
            x1 = @thickness 
            x2 = @width - @thickness
            y1 = 0
            y2 = @depth - @thickness
            z = height
    
            # Create a series of "points", each a 3-item array containing x, y, and z.
            pt1 = [x1, y1, z]
            pt2 = [x2, y1, z]
            pt3 = [x2, y2, z]
            pt4 = [x1, y2, z]

            draw_panel "Space", pt1, pt2, pt3, pt4, thickness
        end
    end

    def draw_sides    
        thickness = @height
              
        # Left
        x1 = 0
        x2 = @thickness
        y1 = 0
        y2 = @depth - @thickness
        z = @thickness
    
        # Create a series of "points", each a 3-item array containing x, y, and z.
        pt1 = [x1, y1, z]
        pt2 = [x2, y1, z]
        pt3 = [x2, y2, z]
        pt4 = [x1, y2, z]

        draw_panel "Left", pt1, pt2, pt3, pt4, thickness

        # Right
        x1 = @width - @thickness
        x2 = @width
        y1 = 0
        y2 = @depth - @thickness
        
        # Create a series of "points", each a 3-item array containing x, y, and z.
        pt1 = [x1, y1, z]
        pt2 = [x2, y1, z]
        pt3 = [x2, y2, z]
        pt4 = [x1, y2, z]

        draw_panel "Right", pt1, pt2, pt3, pt4, thickness

        # Back
        x1 = 0
        x2 = @width
        y1 = @depth - @thickness
        y2 = @depth
        
        # Create a series of "points", each a 3-item array containing x, y, and z.
        pt1 = [x1, y1, z]
        pt2 = [x2, y1, z]
        pt3 = [x2, y2, z]
        pt4 = [x1, y2, z]

        draw_panel "Back", pt1, pt2, pt3, pt4, thickness
    end
end

#-----------------------------------------------------------------------------

def draw_bookcase
    # With four params, it shows a drop down box for prompts that have 
    # pipe-delimited lists of options. In this case, the Gender prompt
    # is a drop down instead of a text box.
    prompts = ["Width (inches)", "Spaces", "Depth (inches)"]
    defaults = [32, 3, 9]
    list = ['32|36|42|48', '2|3|4|5|6|7', '7|9|9.25|11|12|13']
    input = UI.inputbox prompts, defaults, list, "Bookcase Dimensions"
    
    # Dimensions
    spaces = input[1].to_i;
    width = input[0].to_i;
    depth = input[2].to_f;
      
    # Draw a bookcase
    object = Bookcase.new(spaces, width, depth)
    object.draw()
end

if( not file_loaded?("Bookcase.rb") )
    UI.menu("Plugins").add_item("Bookcase") { draw_bookcase }
end

file_loaded("Bookcase.rb")
