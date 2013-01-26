require 'spec_helper'

describe "me/notifications/edit" do
  before(:each) do
    @me_notification = assign(:me_notification, stub_model(Me::Notification))
  end

  it "renders the edit me_notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_notifications_path(@me_notification), :method => "post" do
    end
  end
end
