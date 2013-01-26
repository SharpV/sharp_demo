require 'spec_helper'

describe "me/settings/new" do
  before(:each) do
    assign(:me_setting, stub_model(Me::Setting).as_new_record)
  end

  it "renders new me_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_settings_path, :method => "post" do
    end
  end
end
