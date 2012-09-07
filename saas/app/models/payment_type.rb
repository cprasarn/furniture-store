class PaymentType < ActiveRecord::Base
  self.table_name = 'payment_type'
  self.primary_key = :name
  
  attr_accessible :name, :description
end
