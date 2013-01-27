require 'spec_helper'

describe "me/plans/new" do
  before(:each) do
    assign(:me_plan, stub_model(Me::Plan).as_new_record)
  end

  it "renders new me_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_plans_path, :method => "post" do
    end
  end
end
