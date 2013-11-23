require 'spec_helper'

describe "issues/show" do
  before(:each) do
    @issue = assign(:issue, stub_model(Issue,
      :organization_id => 1,
      :name => "Name",
      :url => "Url",
      :issue_id => 2,
      :status => "Status",
      :level => 3,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/Url/)
    rendered.should match(/2/)
    rendered.should match(/Status/)
    rendered.should match(/3/)
    rendered.should match(/MyText/)
  end
end
