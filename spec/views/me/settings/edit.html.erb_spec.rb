require 'spec_helper'

describe "me/settings/edit" do
  before(:each) do
    @me_setting = assign(:me_setting, stub_model(Me::Setting))
  end

  it "renders the edit me_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_settings_path(@me_setting), :method => "post" do
    end
  end
end
