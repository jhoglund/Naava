require 'spec_helper'

describe "/attendants/show.html.erb" do
  include AttendantsHelper
  before(:each) do
    assigns[:attendant] = @attendant = stub_model(Attendant,
      :participant => 1,
      :session => 1,
      :status => 1,
      :comment => "value for comment"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ comment/)
  end
end
