require 'spec_helper'

describe "me/plans/index" do
  before(:each) do
    assign(:me_plans, [
      stub_model(Me::Plan),
      stub_model(Me::Plan)
    ])
  end

  it "renders a list of me/plans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
