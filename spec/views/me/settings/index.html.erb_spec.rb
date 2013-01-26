require 'spec_helper'

describe "me/settings/index" do
  before(:each) do
    assign(:me_settings, [
      stub_model(Me::Setting),
      stub_model(Me::Setting)
    ])
  end

  it "renders a list of me/settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
