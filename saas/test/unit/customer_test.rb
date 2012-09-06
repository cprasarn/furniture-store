# == Schema Information
#
# Table name: customers
#
#  id             :integer(3)      not null, primary key
#  name           :string(80)      not null
#  home_phone     :string(20)
#  mobile_phone   :string(20)
#  business_phone :string(20)
#  fax            :string(20)
#  email          :string(80)
#  create_date    :datetime        not null
#  modify_date    :datetime
#  status         :integer(1)      default(1), not null
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
