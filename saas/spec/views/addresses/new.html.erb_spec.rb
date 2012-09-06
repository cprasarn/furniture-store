require 'spec_helper'

describe "addresses/new" do
  before(:each) do
    assign(:address, stub_model(Address,
      :street1 => "MyString",
      :street2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip_code => "MyString",
      :status => 1
    ).as_new_record)
  end

  it "renders new address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => addresses_path, :method => "post" do
      assert_select "input#address_street1", :name => "address[street1]"
      assert_select "input#address_street2", :name => "address[street2]"
      assert_select "input#address_city", :name => "address[city]"
      assert_select "input#address_state", :name => "address[state]"
      assert_select "input#address_zip_code", :name => "address[zip_code]"
      assert_select "input#address_status", :name => "address[status]"
    end
  end
end
