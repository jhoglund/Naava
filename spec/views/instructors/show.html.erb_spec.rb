require 'spec_helper'

describe "/instructors/show.html.erb" do
  include InstructorsHelper
  before(:each) do
    assigns[:instructor] = @instructor = stub_model(Instructor,
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone",
      :bio => "value for bio",
      :description => "value for description"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ email/)
    response.should have_text(/value\ for\ phone/)
    response.should have_text(/value\ for\ bio/)
    response.should have_text(/value\ for\ description/)
  end
end
