require 'spec_helper'

describe "me/documents/show" do
  before(:each) do
    @me_document = assign(:me_document, stub_model(Me::Document))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
