require 'spec_helper'

describe "/bankgiros/index.html.erb" do
  include BankgirosHelper

  before(:each) do
    assigns[:bankgiros] = [
      stub_model(Bankgiro,
        :avinr => 1,
        :payment => 1,
        :gross => 1
      ),
      stub_model(Bankgiro,
        :avinr => 1,
        :payment => 1,
        :gross => 1
      )
    ]
  end

  it "renders a list of bankgiros" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
