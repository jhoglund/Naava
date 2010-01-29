require 'spec_helper'

describe "/cashes/index.html.erb" do
  include CashesHelper

  before(:each) do
    assigns[:cashes] = [
      stub_model(Cash,
        :gross => 1
      ),
      stub_model(Cash,
        :gross => 1
      )
    ]
  end

  it "renders a list of cashes" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
