require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :id => "Id",
        :order_number => "Order Number",
        :image_uri => "Image Uri",
        :description => "Description",
        :status => 1
      ),
      stub_model(Item,
        :id => "Id",
        :order_number => "Order Number",
        :image_uri => "Image Uri",
        :description => "Description",
        :status => 1
      )
    ])
  end

  it "renders a list of items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Id".to_s, :count => 2
    assert_select "tr>td", :text => "Order Number".to_s, :count => 2
    assert_select "tr>td", :text => "Image Uri".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
