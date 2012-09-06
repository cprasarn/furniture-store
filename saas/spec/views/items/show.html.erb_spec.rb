require 'spec_helper'

describe "items/show" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :id => "Id",
      :order_number => "Order Number",
      :image_uri => "Image Uri",
      :description => "Description",
      :status => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Id/)
    rendered.should match(/Order Number/)
    rendered.should match(/Image Uri/)
    rendered.should match(/Description/)
    rendered.should match(/1/)
  end
end
