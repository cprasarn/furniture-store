# == Schema Information
#
# Table name: orders
#
#  id              :string(128)     not null, primary key
#  order_number    :string(10)      not null
#  customer_id     :integer(3)      not null
#  lead_source     :string(255)
#  delivery_option :string(80)
#  price           :float
#  finishing_cost  :float
#  delivery_charge :float
#  sales_tax       :float
#  payment_method  :string(20)
#  deposit         :float
#  balance         :float
#  order_date      :datetime        not null
#  due_date        :date
#  delivery_date   :date
#  status          :integer(1)      default(1), not null
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
