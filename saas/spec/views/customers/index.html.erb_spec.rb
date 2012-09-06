require 'spec_helper'

describe "customers/index" do
  before(:each) do
    assign(:customers, [
      stub_model(Customer,
        :id => 1,
        :name => "Name",
        :home_phone => "Home Phone",
        :mobile_phone => "Mobile Phone",
        :business_phone => "Business Phone",
        :fax => "Fax",
        :email => "Email",
        :status => 2
      ),
      stub_model(Customer,
        :id => 1,
        :name => "Name",
        :home_phone => "Home Phone",
        :mobile_phone => "Mobile Phone",
        :business_phone => "Business Phone",
        :fax => "Fax",
        :email => "Email",
        :status => 2
      )
    ])
  end

  it "renders a list of customers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Home Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Business Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Fax".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
