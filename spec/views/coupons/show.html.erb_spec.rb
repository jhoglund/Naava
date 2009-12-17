require 'spec_helper'

describe "/coupons/show.html.erb" do
  include CouponsHelper
  before(:each) do
    assigns[:coupon] = @coupon = stub_model(Coupon,
      :to_name => "value for to_name",
      :to_email => "value for to_email",
      :to_phone => "value for to_phone",
      :to_address => "value for to_address",
      :from_name => "value for from_name",
      :from_email => "value for from_email",
      :from_phone => "value for from_phone",
      :from_address => "value for from_address",
      :message => "value for message",
      :coupon_type => 1,
      :payment_id => 1,
      :payment_type => "value for payment_type"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ to_name/)
    response.should have_text(/value\ for\ to_email/)
    response.should have_text(/value\ for\ to_phone/)
    response.should have_text(/value\ for\ to_address/)
    response.should have_text(/value\ for\ from_name/)
    response.should have_text(/value\ for\ from_email/)
    response.should have_text(/value\ for\ from_phone/)
    response.should have_text(/value\ for\ from_address/)
    response.should have_text(/value\ for\ message/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ payment_type/)
  end
end
