require 'spec_helper'

describe "customers_addresses/new" do
  before(:each) do
    assign(:customers_address, stub_model(CustomersAddress,
      :id => "MyString",
      :customer_id => 1,
      :address_id => "MyString",
      :type => "",
      :status => 1
    ).as_new_record)
  end

  it "renders new customers_address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customers_addresses_path, :method => "post" do
      assert_select "input#customers_address_id", :name => "customers_address[id]"
      assert_select "input#customers_address_customer_id", :name => "customers_address[customer_id]"
      assert_select "input#customers_address_address_id", :name => "customers_address[address_id]"
      assert_select "input#customers_address_type", :name => "customers_address[type]"
      assert_select "input#customers_address_status", :name => "customers_address[status]"
    end
  end
end
