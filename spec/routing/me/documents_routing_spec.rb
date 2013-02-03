require "spec_helper"

describe Me::DocumentsController do
  describe "routing" do

    it "routes to #index" do
      get("/me/documents").should route_to("me/documents#index")
    end

    it "routes to #new" do
      get("/me/documents/new").should route_to("me/documents#new")
    end

    it "routes to #show" do
      get("/me/documents/1").should route_to("me/documents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/me/documents/1/edit").should route_to("me/documents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/me/documents").should route_to("me/documents#create")
    end

    it "routes to #update" do
      put("/me/documents/1").should route_to("me/documents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/me/documents/1").should route_to("me/documents#destroy", :id => "1")
    end

  end
end
