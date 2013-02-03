require 'spec_helper'

describe "me/notes/show" do
  before(:each) do
    @me_note = assign(:me_note, stub_model(Me::Note))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
