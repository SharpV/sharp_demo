require 'spec_helper'

describe "me/plans/show" do
  before(:each) do
    @me_plan = assign(:me_plan, stub_model(Me::Plan))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
