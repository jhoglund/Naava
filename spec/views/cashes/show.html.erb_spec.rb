require 'spec_helper'

describe "/cashes/show.html.erb" do
  include CashesHelper
  before(:each) do
    assigns[:cash] = @cash = stub_model(Cash,
      :gross => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
  end
end
