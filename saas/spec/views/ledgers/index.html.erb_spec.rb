require 'spec_helper'

describe "ledgers/index" do
  before(:each) do
    assign(:ledgers, [
      stub_model(Ledger,
        :id => "Id",
        :order_number => "Order Number",
        :payment_type => "Payment Type",
        :payment_method => "Payment Method",
        :amount => 1.5,
        :status => ""
      ),
      stub_model(Ledger,
        :id => "Id",
        :order_number => "Order Number",
        :payment_type => "Payment Type",
        :payment_method => "Payment Method",
        :amount => 1.5,
        :status => ""
      )
    ])
  end

  it "renders a list of ledgers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Id".to_s, :count => 2
    assert_select "tr>td", :text => "Order Number".to_s, :count => 2
    assert_select "tr>td", :text => "Payment Type".to_s, :count => 2
    assert_select "tr>td", :text => "Payment Method".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
