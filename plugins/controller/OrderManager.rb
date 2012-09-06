require '57th/data/Customer.rb'
require '57th/data/OrderNumber.rb'
require '57th/data/Order.rb'
require '57th/data/Item.rb'

require 'json'
require 'pathname'

module OrderManager
  IMAGE_DIRECTORY = 'C:/Users/Noi/Documents/GitHub/furniture-store/saas/app/assets/images/items/'
  
  def export_image(item_name)
    image_uri = IMAGE_DIRECTORY + item_name
    keys = {
      :filename => image_uri,
      :width => 960,
      :height => 720,
      :antialias => false,
      :compression => 0.9,
      :transparent => true
    }
    
    begin
      model = Sketchup.active_model
      view = model.active_view
      view.write_image keys
    rescue KeyError => e
      error_message = "[OrderManager::export_image] Error [#{e.err}]: #{e.errstr}"
      puts error_message
    end
    
    return image_uri
  end
  
  def get_customer_info
    prompts = ["Name", "Phone", "Email"]
    defaults = ['', '', '']
    input = UI.inputbox prompts, defaults, "Customer Information"
    
    # Customer Information
    vo = CustomerVo.new()
    vo.name = input[0];
    vo.home_phone = input[1];
    vo.email = input[2];
      
    return vo    
  end
  
  def get_order_info
    prompts = ["Delivery Option", "Deposit", "Payment Method", "Due Date"]
    defaults = ['', nil, 'Credit Card', nil]
    list = ['Evanston|Cermak|Delivery', nil, 'Credit Card|Check|Cash', nil]
    input = UI.inputbox prompts, defaults, list, "Order Information"
    
    # Customer Information
    vo = OrderVo.new()
    vo.delivery_option = input[0];
    vo.deposit = input[1];
    vo.payment_method = input[2];
    vo.due_date = input[3];
      
    return vo
  end
  
  def get_item_info
    prompts = ["Description"]
    defaults = ['']
    input = UI.inputbox prompts, defaults, "Item Information"
    
    # Customer Information
    vo = ItemVo.new()
    vo.description = input[0];
      
    return vo    
  end
    
  def process_order
    begin
      # Dialog
      order_dialog = UI::WebDialog.new("Order", false, "Order_From", 840, 480, 100, 200, true)
      order_dialog.set_url "http://localhost:3000/items/new?sketchup=1"
      
      order_dialog.add_action_callback('export_image') { 
        |dialog, arg|
        item_name = arg.to_s()
        OrderManager.export_image(item_name[6,item_name.size])
      }
      
      order_dialog.show_modal

    rescue KeyError => e
      error_message = "[OrderManager::process_order] Error [#{e.err}]: #{e.errstr}"
      UI.messagebox(error_message)        
    rescue ArgumentError => e
      error_message = "[OrderManager::process_order] Error [#{e.err}]: #{e.errstr}"
      UI.messagebox(error_message)        
    rescue DBI::DatabaseError => e
      error_message = "[OrderManager::process_order] Error [#{e.err}]: #{e.errstr}"
      UI.messagebox(error_message)        
    end
  end
  
  module_function :export_image, :process_order, :get_customer_info, :get_order_info, :get_item_info
end

if( not file_loaded?("OrderManager.rb") )
  UI.menu("Plugins").add_item("Create/Update Order") { OrderManager.process_order }
end

file_loaded("OrderManager.rb")
