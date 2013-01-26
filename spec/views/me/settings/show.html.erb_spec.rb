require 'spec_helper'

describe "me/settings/show" do
  before(:each) do
    @me_setting = assign(:me_setting, stub_model(Me::Setting))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
