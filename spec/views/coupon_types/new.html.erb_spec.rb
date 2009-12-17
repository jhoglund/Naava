require 'spec_helper'

describe "/coupon_types/new.html.erb" do
  include CouponTypesHelper

  before(:each) do
    assigns[:coupon_type] = stub_model(CouponType,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :value => 1
    )
  end

  it "renders new coupon_type form" do
    render

    response.should have_tag("form[action=?][method=post]", coupon_types_path) do
      with_tag("input#coupon_type_name[name=?]", "coupon_type[name]")
      with_tag("textarea#coupon_type_description[name=?]", "coupon_type[description]")
      with_tag("input#coupon_type_value[name=?]", "coupon_type[value]")
    end
  end
end
