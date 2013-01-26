require 'spec_helper'

describe "me/school_classes/show" do
  before(:each) do
    @me_school_class = assign(:me_school_class, stub_model(Me::SchoolClass))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
