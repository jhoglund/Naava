require 'spec_helper'

describe "/participants/index.html.erb" do
  include ParticipantsHelper

  before(:each) do
    assigns[:participants] = [
      stub_model(Participant,
        :name => "value for name",
        :email => "value for email",
        :phone => "value for phone"
      ),
      stub_model(Participant,
        :name => "value for name",
        :email => "value for email",
        :phone => "value for phone"
      )
    ]
  end

  it "renders a list of participants" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for email".to_s, 2)
    response.should have_tag("tr>td", "value for phone".to_s, 2)
  end
end
