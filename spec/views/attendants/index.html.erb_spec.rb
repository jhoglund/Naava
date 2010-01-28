require 'spec_helper'

describe "/attendants/index.html.erb" do
  include AttendantsHelper

  before(:each) do
    assigns[:attendants] = [
      stub_model(Attendant,
        :participant => 1,
        :session => 1,
        :status => 1,
        :comment => "value for comment"
      ),
      stub_model(Attendant,
        :participant => 1,
        :session => 1,
        :status => 1,
        :comment => "value for comment"
      )
    ]
  end

  it "renders a list of attendants" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for comment".to_s, 2)
  end
end
