require 'spec_helper'

describe "me/plans/edit" do
  before(:each) do
    @me_plan = assign(:me_plan, stub_model(Me::Plan))
  end

  it "renders the edit me_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_plans_path(@me_plan), :method => "post" do
    end
  end
end
