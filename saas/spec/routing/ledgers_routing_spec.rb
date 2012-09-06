require "spec_helper"

describe LedgersController do
  describe "routing" do

    it "routes to #index" do
      get("/ledgers").should route_to("ledgers#index")
    end

    it "routes to #new" do
      get("/ledgers/new").should route_to("ledgers#new")
    end

    it "routes to #show" do
      get("/ledgers/1").should route_to("ledgers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ledgers/1/edit").should route_to("ledgers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ledgers").should route_to("ledgers#create")
    end

    it "routes to #update" do
      put("/ledgers/1").should route_to("ledgers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ledgers/1").should route_to("ledgers#destroy", :id => "1")
    end

  end
end
