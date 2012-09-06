require 'spec_helper'

describe "customers/new" do
  before(:each) do
    assign(:customer, stub_model(Customer,
      :id => 1,
      :name => "MyString",
      :home_phone => "MyString",
      :mobile_phone => "MyString",
      :business_phone => "MyString",
      :fax => "MyString",
      :email => "MyString",
      :status => 1
    ).as_new_record)
  end

  it "renders new customer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customers_path, :method => "post" do
      assert_select "input#customer_id", :name => "customer[id]"
      assert_select "input#customer_name", :name => "customer[name]"
      assert_select "input#customer_home_phone", :name => "customer[home_phone]"
      assert_select "input#customer_mobile_phone", :name => "customer[mobile_phone]"
      assert_select "input#customer_business_phone", :name => "customer[business_phone]"
      assert_select "input#customer_fax", :name => "customer[fax]"
      assert_select "input#customer_email", :name => "customer[email]"
      assert_select "input#customer_status", :name => "customer[status]"
    end
  end
end
