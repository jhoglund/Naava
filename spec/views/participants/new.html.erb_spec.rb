require 'spec_helper'

describe "/participants/new.html.erb" do
  include ParticipantsHelper

  before(:each) do
    assigns[:participant] = stub_model(Participant,
      :new_record? => true,
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone"
    )
  end

  it "renders new participant form" do
    render

    response.should have_tag("form[action=?][method=post]", participants_path) do
      with_tag("input#participant_name[name=?]", "participant[name]")
      with_tag("input#participant_email[name=?]", "participant[email]")
      with_tag("input#participant_phone[name=?]", "participant[phone]")
    end
  end
end
