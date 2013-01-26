require "spec_helper"

describe Me::SchoolClassesController do
  describe "routing" do

    it "routes to #index" do
      get("/me/school_classes").should route_to("me/school_classes#index")
    end

    it "routes to #new" do
      get("/me/school_classes/new").should route_to("me/school_classes#new")
    end

    it "routes to #show" do
      get("/me/school_classes/1").should route_to("me/school_classes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/me/school_classes/1/edit").should route_to("me/school_classes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/me/school_classes").should route_to("me/school_classes#create")
    end

    it "routes to #update" do
      put("/me/school_classes/1").should route_to("me/school_classes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/me/school_classes/1").should route_to("me/school_classes#destroy", :id => "1")
    end

  end
end
