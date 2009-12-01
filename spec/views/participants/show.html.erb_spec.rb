require 'spec_helper'

describe "/participants/show.html.erb" do
  include ParticipantsHelper
  before(:each) do
    assigns[:participant] = @participant = stub_model(Participant,
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ email/)
    response.should have_text(/value\ for\ phone/)
  end
end
