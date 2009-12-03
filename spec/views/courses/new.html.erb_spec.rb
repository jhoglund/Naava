require 'spec_helper'

describe "/courses/new.html.erb" do
  include CoursesHelper

  before(:each) do
    assigns[:course] = stub_model(Course,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :level => "value for level"
    )
  end

  it "renders new course form" do
    render

    response.should have_tag("form[action=?][method=post]", courses_path) do
      with_tag("input#course_name[name=?]", "course[name]")
      with_tag("textarea#course_description[name=?]", "course[description]")
      with_tag("input#course_level[name=?]", "course[level]")
    end
  end
end
