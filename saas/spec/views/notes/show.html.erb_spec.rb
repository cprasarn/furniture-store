require 'spec_helper'

describe "notes/show" do
  before(:each) do
    @note = assign(:note, stub_model(Note,
      :order_number => "Order Number",
      :note_type => "Note Type",
      :content => "Content"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Order Number/)
    rendered.should match(/Note Type/)
    rendered.should match(/Content/)
  end
end
