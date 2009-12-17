require 'spec_helper'

describe "/coupon_types/show.html.erb" do
  include CouponTypesHelper
  before(:each) do
    assigns[:coupon_type] = @coupon_type = stub_model(CouponType,
      :name => "value for name",
      :description => "value for description",
      :value => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/1/)
  end
end
