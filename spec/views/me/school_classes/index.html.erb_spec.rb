require 'spec_helper'

describe "me/school_classes/index" do
  before(:each) do
    assign(:me_school_classes, [
      stub_model(Me::SchoolClass),
      stub_model(Me::SchoolClass)
    ])
  end

  it "renders a list of me/school_classes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
