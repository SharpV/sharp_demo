require 'spec_helper'

describe "me/school_classes/edit" do
  before(:each) do
    @me_school_class = assign(:me_school_class, stub_model(Me::SchoolClass))
  end

  it "renders the edit me_school_class form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_school_classes_path(@me_school_class), :method => "post" do
    end
  end
end
