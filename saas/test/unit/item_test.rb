# == Schema Information
#
# Table name: items
#
#  id             :string(128)     not null, primary key
#  order_number   :string(10)      not null
#  image_uri      :string(255)     not null
#  description    :string(255)
#  price          :float
#  finishing_cost :float
#  sales_tax      :float
#  create_date    :datetime        not null
#  status         :integer(1)      default(1), not null
#

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
