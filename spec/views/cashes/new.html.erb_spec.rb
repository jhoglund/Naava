require 'spec_helper'

describe "/cashes/new.html.erb" do
  include CashesHelper

  before(:each) do
    assigns[:cash] = stub_model(Cash,
      :new_record? => true,
      :gross => 1
    )
  end

  it "renders new cash form" do
    render

    response.should have_tag("form[action=?][method=post]", cashes_path) do
      with_tag("input#cash_gross[name=?]", "cash[gross]")
    end
  end
end
