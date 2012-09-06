require 'spec_helper'

describe "ledgers/edit" do
  before(:each) do
    @ledger = assign(:ledger, stub_model(Ledger,
      :id => "MyString",
      :order_number => "MyString",
      :payment_type => "MyString",
      :payment_method => "MyString",
      :amount => 1.5,
      :status => ""
    ))
  end

  it "renders the edit ledger form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ledgers_path(@ledger), :method => "post" do
      assert_select "input#ledger_id", :name => "ledger[id]"
      assert_select "input#ledger_order_number", :name => "ledger[order_number]"
      assert_select "input#ledger_payment_type", :name => "ledger[payment_type]"
      assert_select "input#ledger_payment_method", :name => "ledger[payment_method]"
      assert_select "input#ledger_amount", :name => "ledger[amount]"
      assert_select "input#ledger_status", :name => "ledger[status]"
    end
  end
end
