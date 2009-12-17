require 'spec_helper'

describe "/coupons/index.html.erb" do
  include CouponsHelper

  before(:each) do
    assigns[:coupons] = [
      stub_model(Coupon,
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
      ),
      stub_model(Coupon,
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
    ]
  end

  it "renders a list of coupons" do
    render
    response.should have_tag("tr>td", "value for to_name".to_s, 2)
    response.should have_tag("tr>td", "value for to_email".to_s, 2)
    response.should have_tag("tr>td", "value for to_phone".to_s, 2)
    response.should have_tag("tr>td", "value for to_address".to_s, 2)
    response.should have_tag("tr>td", "value for from_name".to_s, 2)
    response.should have_tag("tr>td", "value for from_email".to_s, 2)
    response.should have_tag("tr>td", "value for from_phone".to_s, 2)
    response.should have_tag("tr>td", "value for from_address".to_s, 2)
    response.should have_tag("tr>td", "value for message".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for payment_type".to_s, 2)
  end
end
