module AddressesHelper
  def process(address, customer)
    if (address.id.nil? or address.id.empty?) and address.save then
      # New address
      # Get the current primary address
      current_primary_address = CustomersAddress.get_primary(customer_id)
      if !current_primary_address.nil? 
        current_primary_address.update_attributes(:is_primary => 0) 
      end
        
      # Save customer address
      ca = CustomersAddress.new
      ca.customer_id = customer_id
      ca.address_id = address.id
      ca.is_primary = 1 # new primary address
      ca.save
    else
      # Existing address; in case there is any changes/updates to the address.
      # Persist new address and change the customer default address
      original_address = Address.find(address.id)
      if original_address != address
        new_address = address.dup
        new_address.save
        address = new_address
          
        # Update customer primary address
        ca = CustomersAddress.get_by_customer_address(customer.id, original_address.id)
        ca.update_attributes(:address_id => address.id)
      end
    end

    return address
  end
  module_function :process
end
