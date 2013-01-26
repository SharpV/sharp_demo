require "spec_helper"

describe Me::SettingsController do
  describe "routing" do

    it "routes to #index" do
      get("/me/settings").should route_to("me/settings#index")
    end

    it "routes to #new" do
      get("/me/settings/new").should route_to("me/settings#new")
    end

    it "routes to #show" do
      get("/me/settings/1").should route_to("me/settings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/me/settings/1/edit").should route_to("me/settings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/me/settings").should route_to("me/settings#create")
    end

    it "routes to #update" do
      put("/me/settings/1").should route_to("me/settings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/me/settings/1").should route_to("me/settings#destroy", :id => "1")
    end

  end
end
