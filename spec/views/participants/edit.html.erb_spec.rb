require 'spec_helper'

describe "/participants/edit.html.erb" do
  include ParticipantsHelper

  before(:each) do
    assigns[:participant] = @participant = stub_model(Participant,
      :new_record? => false,
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone"
    )
  end

  it "renders the edit participant form" do
    render

    response.should have_tag("form[action=#{participant_path(@participant)}][method=post]") do
      with_tag('input#participant_name[name=?]', "participant[name]")
      with_tag('input#participant_email[name=?]', "participant[email]")
      with_tag('input#participant_phone[name=?]', "participant[phone]")
    end
  end
end
