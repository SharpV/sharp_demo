require 'spec_helper'

describe "me/notes/index" do
  before(:each) do
    assign(:me_notes, [
      stub_model(Me::Note),
      stub_model(Me::Note)
    ])
  end

  it "renders a list of me/notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
