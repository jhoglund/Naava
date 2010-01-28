require 'spec_helper'

describe "/attendants/edit.html.erb" do
  include AttendantsHelper

  before(:each) do
    assigns[:attendant] = @attendant = stub_model(Attendant,
      :new_record? => false,
      :participant => 1,
      :session => 1,
      :status => 1,
      :comment => "value for comment"
    )
  end

  it "renders the edit attendant form" do
    render

    response.should have_tag("form[action=#{attendant_path(@attendant)}][method=post]") do
      with_tag('input#attendant_participant[name=?]', "attendant[participant]")
      with_tag('input#attendant_session[name=?]', "attendant[session]")
      with_tag('input#attendant_status[name=?]', "attendant[status]")
      with_tag('textarea#attendant_comment[name=?]', "attendant[comment]")
    end
  end
end
