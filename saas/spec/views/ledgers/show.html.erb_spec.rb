require 'spec_helper'

describe "ledgers/show" do
  before(:each) do
    @ledger = assign(:ledger, stub_model(Ledger,
      :id => "Id",
      :order_number => "Order Number",
      :payment_type => "Payment Type",
      :payment_method => "Payment Method",
      :amount => 1.5,
      :status => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Id/)
    rendered.should match(/Order Number/)
    rendered.should match(/Payment Type/)
    rendered.should match(/Payment Method/)
    rendered.should match(/1.5/)
    rendered.should match(//)
  end
end
