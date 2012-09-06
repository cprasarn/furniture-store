require 'spec_helper'

describe "roles/show" do
  before(:each) do
    @role = assign(:role, stub_model(Role,
      :id => 1,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
  end
end
