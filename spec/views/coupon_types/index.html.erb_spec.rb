require 'spec_helper'

describe "/coupon_types/index.html.erb" do
  include CouponTypesHelper

  before(:each) do
    assigns[:coupon_types] = [
      stub_model(CouponType,
        :name => "value for name",
        :description => "value for description",
        :value => 1
      ),
      stub_model(CouponType,
        :name => "value for name",
        :description => "value for description",
        :value => 1
      )
    ]
  end

  it "renders a list of coupon_types" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
