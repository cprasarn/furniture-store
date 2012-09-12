module ItemsHelper
  def is_sketchup?
    OrdersHelper.browser_type(request, 'SketchUp')
  end  
end
