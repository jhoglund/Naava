require 'spec_helper'

describe "/coupon_types/edit.html.erb" do
  include CouponTypesHelper

  before(:each) do
    assigns[:coupon_type] = @coupon_type = stub_model(CouponType,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description",
      :value => 1
    )
  end

  it "renders the edit coupon_type form" do
    render

    response.should have_tag("form[action=#{coupon_type_path(@coupon_type)}][method=post]") do
      with_tag('input#coupon_type_name[name=?]', "coupon_type[name]")
      with_tag('textarea#coupon_type_description[name=?]', "coupon_type[description]")
      with_tag('input#coupon_type_value[name=?]', "coupon_type[value]")
    end
  end
end
