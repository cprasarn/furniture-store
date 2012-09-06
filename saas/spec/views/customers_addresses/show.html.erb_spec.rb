require 'spec_helper'

describe "customers_addresses/show" do
  before(:each) do
    @customers_address = assign(:customers_address, stub_model(CustomersAddress,
      :id => "Id",
      :customer_id => 1,
      :address_id => "Address",
      :type => "Type",
      :status => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Id/)
    rendered.should match(/1/)
    rendered.should match(/Address/)
    rendered.should match(/Type/)
    rendered.should match(/2/)
  end
end
