require 'spec_helper'

describe "/attendants/new.html.erb" do
  include AttendantsHelper

  before(:each) do
    assigns[:attendant] = stub_model(Attendant,
      :new_record? => true,
      :participant => 1,
      :session => 1,
      :status => 1,
      :comment => "value for comment"
    )
  end

  it "renders new attendant form" do
    render

    response.should have_tag("form[action=?][method=post]", attendants_path) do
      with_tag("input#attendant_participant[name=?]", "attendant[participant]")
      with_tag("input#attendant_session[name=?]", "attendant[session]")
      with_tag("input#attendant_status[name=?]", "attendant[status]")
      with_tag("textarea#attendant_comment[name=?]", "attendant[comment]")
    end
  end
end
