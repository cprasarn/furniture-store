require 'spec_helper'

describe "orders/index" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
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
      ),
      stub_model(Order,
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
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Id".to_s, :count => 2
    assert_select "tr>td", :text => "Order Number".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Delivery Option".to_s, :count => 2
    assert_select "tr>td", :text => "Lead Source".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
