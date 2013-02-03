require "spec_helper"

describe Me::NotesController do
  describe "routing" do

    it "routes to #index" do
      get("/me/notes").should route_to("me/notes#index")
    end

    it "routes to #new" do
      get("/me/notes/new").should route_to("me/notes#new")
    end

    it "routes to #show" do
      get("/me/notes/1").should route_to("me/notes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/me/notes/1/edit").should route_to("me/notes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/me/notes").should route_to("me/notes#create")
    end

    it "routes to #update" do
      put("/me/notes/1").should route_to("me/notes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/me/notes/1").should route_to("me/notes#destroy", :id => "1")
    end

  end
end
