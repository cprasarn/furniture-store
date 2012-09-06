require 'spec_helper'

describe "customers_addresses/index" do
  before(:each) do
    assign(:customers_addresses, [
      stub_model(CustomersAddress,
        :id => "Id",
        :customer_id => 1,
        :address_id => "Address",
        :type => "Type",
        :status => 2
      ),
      stub_model(CustomersAddress,
        :id => "Id",
        :customer_id => 1,
        :address_id => "Address",
        :type => "Type",
        :status => 2
      )
    ])
  end

  it "renders a list of customers_addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Id".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
