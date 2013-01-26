require 'spec_helper'

describe "me/notifications/new" do
  before(:each) do
    assign(:me_notification, stub_model(Me::Notification).as_new_record)
  end

  it "renders new me_notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_notifications_path, :method => "post" do
    end
  end
end
