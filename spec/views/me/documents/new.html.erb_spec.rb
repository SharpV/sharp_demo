require 'spec_helper'

describe "me/documents/new" do
  before(:each) do
    assign(:me_document, stub_model(Me::Document).as_new_record)
  end

  it "renders new me_document form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => me_documents_path, :method => "post" do
    end
  end
end
