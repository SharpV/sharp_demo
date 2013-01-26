require 'spec_helper'

describe "me/notifications/index" do
  before(:each) do
    assign(:me_notifications, [
      stub_model(Me::Notification),
      stub_model(Me::Notification)
    ])
  end

  it "renders a list of me/notifications" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
