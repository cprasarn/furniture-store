require 'spec_helper'

describe "addresses/show" do
  before(:each) do
    @address = assign(:address, stub_model(Address,
      :street1 => "Street1",
      :street2 => "Street2",
      :city => "City",
      :state => "State",
      :zip_code => "Zip Code",
      :status => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Street1/)
    rendered.should match(/Street2/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zip Code/)
    rendered.should match(/1/)
  end
end
