require "spec_helper"

describe CustomersAddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/customers_addresses").should route_to("customers_addresses#index")
    end

    it "routes to #new" do
      get("/customers_addresses/new").should route_to("customers_addresses#new")
    end

    it "routes to #show" do
      get("/customers_addresses/1").should route_to("customers_addresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/customers_addresses/1/edit").should route_to("customers_addresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/customers_addresses").should route_to("customers_addresses#create")
    end

    it "routes to #update" do
      put("/customers_addresses/1").should route_to("customers_addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/customers_addresses/1").should route_to("customers_addresses#destroy", :id => "1")
    end

  end
end
