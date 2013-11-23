require 'spec_helper'

describe "issues/edit" do
  before(:each) do
    @issue = assign(:issue, stub_model(Issue,
      :organization_id => 1,
      :name => "MyString",
      :url => "MyString",
      :issue_id => 1,
      :status => "MyString",
      :level => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit issue form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", issue_path(@issue), "post" do
      assert_select "input#issue_organization_id[name=?]", "issue[organization_id]"
      assert_select "input#issue_name[name=?]", "issue[name]"
      assert_select "input#issue_url[name=?]", "issue[url]"
      assert_select "input#issue_issue_id[name=?]", "issue[issue_id]"
      assert_select "input#issue_status[name=?]", "issue[status]"
      assert_select "input#issue_level[name=?]", "issue[level]"
      assert_select "textarea#issue_description[name=?]", "issue[description]"
    end
  end
end
