require 'spec_helper'

describe "me/documents/edit" do
  before(:each) do
    @me_document = assign(:me_document, stub_model(Me::Document))
  end

  it "renders the edit me_document form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_documents_path(@me_document), :method => "post" do
    end
  end
end
