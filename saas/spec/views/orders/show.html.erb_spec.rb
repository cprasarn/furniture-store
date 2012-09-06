require 'spec_helper'

describe "orders/show" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :id => "Id",
      :order_number => "Order Number",
      :customer_id => 1,
      :price => 1.5,
      :delivery_option => "Delivery Option",
      :lead_source => "Lead Source",
      :finishing_cost => 1.5,
      :delivery_charge => 1.5,
      :sales_tax => 1.5,
      :balance => 1.5,
      :status => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Id/)
    rendered.should match(/Order Number/)
    rendered.should match(/1/)
    rendered.should match(/1.5/)
    rendered.should match(/Delivery Option/)
    rendered.should match(/Lead Source/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/2/)
  end
end
