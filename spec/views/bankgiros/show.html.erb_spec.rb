require 'spec_helper'

describe "/bankgiros/show.html.erb" do
  include BankgirosHelper
  before(:each) do
    assigns[:bankgiro] = @bankgiro = stub_model(Bankgiro,
      :avinr => 1,
      :payment => 1,
      :gross => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
