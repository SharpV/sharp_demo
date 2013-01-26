require 'spec_helper'

describe "me/school_classes/new" do
  before(:each) do
    assign(:me_school_class, stub_model(Me::SchoolClass).as_new_record)
  end

  it "renders new me_school_class form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_school_classes_path, :method => "post" do
    end
  end
end
