require 'spec_helper'

describe "/cashes/edit.html.erb" do
  include CashesHelper

  before(:each) do
    assigns[:cash] = @cash = stub_model(Cash,
      :new_record? => false,
      :gross => 1
    )
  end

  it "renders the edit cash form" do
    render

    response.should have_tag("form[action=#{cash_path(@cash)}][method=post]") do
      with_tag('input#cash_gross[name=?]', "cash[gross]")
    end
  end
end
