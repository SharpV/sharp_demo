require 'spec_helper'

describe "me/notifications/show" do
  before(:each) do
    @me_notification = assign(:me_notification, stub_model(Me::Notification))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
