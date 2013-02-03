require 'spec_helper'

describe "me/documents/index" do
  before(:each) do
    assign(:me_documents, [
      stub_model(Me::Document),
      stub_model(Me::Document)
    ])
  end

  it "renders a list of me/documents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
