require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :id => "MyString",
      :order_number => "MyString",
      :image_uri => "MyString",
      :description => "MyString",
      :status => 1
    ).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_id", :name => "item[id]"
      assert_select "input#item_order_number", :name => "item[order_number]"
      assert_select "input#item_image_uri", :name => "item[image_uri]"
      assert_select "input#item_description", :name => "item[description]"
      assert_select "input#item_status", :name => "item[status]"
    end
  end
end
