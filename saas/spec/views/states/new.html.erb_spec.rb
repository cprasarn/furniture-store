require 'spec_helper'

describe "states/new" do
  before(:each) do
    assign(:state, stub_model(State,
      :name => "MyString",
      :abbreviation => "MyString"
    ).as_new_record)
  end

  it "renders new state form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => states_path, :method => "post" do
      assert_select "input#state_name", :name => "state[name]"
      assert_select "input#state_abbreviation", :name => "state[abbreviation]"
    end
  end
end
