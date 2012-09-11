require 'spec_helper'

describe "notes/new" do
  before(:each) do
    assign(:note, stub_model(Note,
      :order_number => "MyString",
      :note_type => "MyString",
      :content => "MyString"
    ).as_new_record)
  end

  it "renders new note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path, :method => "post" do
      assert_select "input#note_order_number", :name => "note[order_number]"
      assert_select "input#note_note_type", :name => "note[note_type]"
      assert_select "input#note_content", :name => "note[content]"
    end
  end
end
