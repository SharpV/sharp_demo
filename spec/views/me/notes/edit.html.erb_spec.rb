require 'spec_helper'

describe "me/notes/edit" do
  before(:each) do
    @me_note = assign(:me_note, stub_model(Me::Note))
  end

  it "renders the edit me_note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_notes_path(@me_note), :method => "post" do
    end
  end
end
