require 'spec_helper'

describe "customers/show" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :id => 1,
      :name => "Name",
      :home_phone => "Home Phone",
      :mobile_phone => "Mobile Phone",
      :business_phone => "Business Phone",
      :fax => "Fax",
      :email => "Email",
      :status => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/Home Phone/)
    rendered.should match(/Mobile Phone/)
    rendered.should match(/Business Phone/)
    rendered.should match(/Fax/)
    rendered.should match(/Email/)
    rendered.should match(/2/)
  end
end
