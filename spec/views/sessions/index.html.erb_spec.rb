require 'spec_helper'

describe "/sessions/index.html.erb" do
  include SessionsHelper

  before(:each) do
    assigns[:sessions] = [
      stub_model(Session,
        :cource => 1
      ),
      stub_model(Session,
        :cource => 1
      )
    ]
  end

  it "renders a list of sessions" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
