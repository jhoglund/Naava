require 'spec_helper'

describe "/bankgiros/new.html.erb" do
  include BankgirosHelper

  before(:each) do
    assigns[:bankgiro] = stub_model(Bankgiro,
      :new_record? => true,
      :avinr => 1,
      :payment => 1,
      :gross => 1
    )
  end

  it "renders new bankgiro form" do
    render

    response.should have_tag("form[action=?][method=post]", bankgiros_path) do
      with_tag("input#bankgiro_avinr[name=?]", "bankgiro[avinr]")
      with_tag("input#bankgiro_payment[name=?]", "bankgiro[payment]")
      with_tag("input#bankgiro_gross[name=?]", "bankgiro[gross]")
    end
  end
end
