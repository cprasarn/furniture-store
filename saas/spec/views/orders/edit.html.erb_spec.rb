require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :id => "MyString",
      :order_number => "MyString",
      :customer_id => 1,
      :price => 1.5,
      :delivery_option => "MyString",
      :lead_source => "MyString",
      :finishing_cost => 1.5,
      :delivery_charge => 1.5,
      :sales_tax => 1.5,
      :balance => 1.5,
      :status => 1
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orders_path(@order), :method => "post" do
      assert_select "input#order_id", :name => "order[id]"
      assert_select "input#order_order_number", :name => "order[order_number]"
      assert_select "input#order_customer_id", :name => "order[customer_id]"
      assert_select "input#order_price", :name => "order[price]"
      assert_select "input#order_delivery_option", :name => "order[delivery_option]"
      assert_select "input#order_lead_source", :name => "order[lead_source]"
      assert_select "input#order_finishing_cost", :name => "order[finishing_cost]"
      assert_select "input#order_delivery_charge", :name => "order[delivery_charge]"
      assert_select "input#order_sales_tax", :name => "order[sales_tax]"
      assert_select "input#order_balance", :name => "order[balance]"
      assert_select "input#order_status", :name => "order[status]"
    end
  end
end
