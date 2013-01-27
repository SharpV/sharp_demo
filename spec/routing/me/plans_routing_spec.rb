require "spec_helper"

describe Me::PlansController do
  describe "routing" do

    it "routes to #index" do
      get("/me/plans").should route_to("me/plans#index")
    end

    it "routes to #new" do
      get("/me/plans/new").should route_to("me/plans#new")
    end

    it "routes to #show" do
      get("/me/plans/1").should route_to("me/plans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/me/plans/1/edit").should route_to("me/plans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/me/plans").should route_to("me/plans#create")
    end

    it "routes to #update" do
      put("/me/plans/1").should route_to("me/plans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/me/plans/1").should route_to("me/plans#destroy", :id => "1")
    end

  end
end
