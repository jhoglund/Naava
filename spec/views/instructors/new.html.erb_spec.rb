require 'spec_helper'

describe "/instructors/new.html.erb" do
  include InstructorsHelper

  before(:each) do
    assigns[:instructor] = stub_model(Instructor,
      :new_record? => true,
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone",
      :bio => "value for bio",
      :description => "value for description"
    )
  end

  it "renders new instructor form" do
    render

    response.should have_tag("form[action=?][method=post]", instructors_path) do
      with_tag("input#instructor_name[name=?]", "instructor[name]")
      with_tag("input#instructor_email[name=?]", "instructor[email]")
      with_tag("input#instructor_phone[name=?]", "instructor[phone]")
      with_tag("textarea#instructor_bio[name=?]", "instructor[bio]")
      with_tag("textarea#instructor_description[name=?]", "instructor[description]")
    end
  end
end
