module CustomersHelper
  def process(customer)
    if 0 == customer.id.to_i
      # New customer
      customer.save
    else
      # Existing customer, if there is any change to the customer detail,
      # persist the changes
      original_customer = Customer.find(customer.id)
      if original_customer != customer
        customer.save
      end
    end
    
    return customer
  end
  
  module_function :process
end
