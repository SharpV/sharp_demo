require 'spec_helper'

describe "me/notes/new" do
  before(:each) do
    assign(:me_note, stub_model(Me::Note).as_new_record)
  end

  it "renders new me_note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_notes_path, :method => "post" do
    end
  end
end
