require 'spec_helper'

describe "Me::Plans" do
  describe "GET /me_plans" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get me_plans_path
      response.status.should be(200)
    end
  end
end
