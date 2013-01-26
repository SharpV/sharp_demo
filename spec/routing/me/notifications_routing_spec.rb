require "spec_helper"

describe Me::NotificationsController do
  describe "routing" do

    it "routes to #index" do
      get("/me/notifications").should route_to("me/notifications#index")
    end

    it "routes to #new" do
      get("/me/notifications/new").should route_to("me/notifications#new")
    end

    it "routes to #show" do
      get("/me/notifications/1").should route_to("me/notifications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/me/notifications/1/edit").should route_to("me/notifications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/me/notifications").should route_to("me/notifications#create")
    end

    it "routes to #update" do
      put("/me/notifications/1").should route_to("me/notifications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/me/notifications/1").should route_to("me/notifications#destroy", :id => "1")
    end

  end
end
