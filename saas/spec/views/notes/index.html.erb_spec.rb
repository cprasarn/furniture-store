require 'spec_helper'

describe "notes/index" do
  before(:each) do
    assign(:notes, [
      stub_model(Note,
        :order_number => "Order Number",
        :note_type => "Note Type",
        :content => "Content"
      ),
      stub_model(Note,
        :order_number => "Order Number",
        :note_type => "Note Type",
        :content => "Content"
      )
    ])
  end

  it "renders a list of notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Order Number".to_s, :count => 2
    assert_select "tr>td", :text => "Note Type".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
