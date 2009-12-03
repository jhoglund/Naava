require 'spec_helper'

describe "/instructors/index.html.erb" do
  include InstructorsHelper

  before(:each) do
    assigns[:instructors] = [
      stub_model(Instructor,
        :name => "value for name",
        :email => "value for email",
        :phone => "value for phone",
        :bio => "value for bio",
        :description => "value for description"
      ),
      stub_model(Instructor,
        :name => "value for name",
        :email => "value for email",
        :phone => "value for phone",
        :bio => "value for bio",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of instructors" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for email".to_s, 2)
    response.should have_tag("tr>td", "value for phone".to_s, 2)
    response.should have_tag("tr>td", "value for bio".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end
