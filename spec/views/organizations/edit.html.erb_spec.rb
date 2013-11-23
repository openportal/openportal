require 'spec_helper'

describe "organizations/edit" do
  before(:each) do
    @organization = assign(:organization, stub_model(Organization,
      :name => "MyString",
      :description => "MyString",
      :photo_url => "MyString"
    ))
  end

  it "renders the edit organization form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", organization_path(@organization), "post" do
      assert_select "input#organization_name[name=?]", "organization[name]"
      assert_select "input#organization_description[name=?]", "organization[description]"
      assert_select "input#organization_photo_url[name=?]", "organization[photo_url]"
    end
  end
end
