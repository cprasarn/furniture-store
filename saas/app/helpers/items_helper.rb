module ItemsHelper
  def is_sketchup?
    OrdersHelper.browser_type(request, 'SketchUp')
  end  
  
  def process(item, temp_image_file)
    # Build image URI
    item.item_number = Item.next_item_number(item.order_number)
    item.image_uri = 'items/' + item.item_name + '.png'
    if !temp_image_file.nil?
      # Move the temporary file to local repository
      item.save_image_file(temp_image_file.path)
    end
     
    item.save
    
    return item
  end
end
