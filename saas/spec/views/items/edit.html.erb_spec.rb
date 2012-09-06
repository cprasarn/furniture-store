require 'spec_helper'

describe "items/edit" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :id => "MyString",
      :order_number => "MyString",
      :image_uri => "MyString",
      :description => "MyString",
      :status => 1
    ))
  end

  it "renders the edit item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path(@item), :method => "post" do
      assert_select "input#item_id", :name => "item[id]"
      assert_select "input#item_order_number", :name => "item[order_number]"
      assert_select "input#item_image_uri", :name => "item[image_uri]"
      assert_select "input#item_description", :name => "item[description]"
      assert_select "input#item_status", :name => "item[status]"
    end
  end
end
