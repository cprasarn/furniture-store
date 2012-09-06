require 'spec_helper'

describe "addresses/index" do
  before(:each) do
    assign(:addresses, [
      stub_model(Address,
        :street1 => "Street1",
        :street2 => "Street2",
        :city => "City",
        :state => "State",
        :zip_code => "Zip Code",
        :status => 1
      ),
      stub_model(Address,
        :street1 => "Street1",
        :street2 => "Street2",
        :city => "City",
        :state => "State",
        :zip_code => "Zip Code",
        :status => 1
      )
    ])
  end

  it "renders a list of addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Street1".to_s, :count => 2
    assert_select "tr>td", :text => "Street2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip Code".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
