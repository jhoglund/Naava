require 'spec_helper'

describe "/coupons/edit.html.erb" do
  include CouponsHelper

  before(:each) do
    assigns[:coupon] = @coupon = stub_model(Coupon,
      :new_record? => false,
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

  it "renders the edit coupon form" do
    render

    response.should have_tag("form[action=#{coupon_path(@coupon)}][method=post]") do
      with_tag('input#coupon_to_name[name=?]', "coupon[to_name]")
      with_tag('input#coupon_to_email[name=?]', "coupon[to_email]")
      with_tag('input#coupon_to_phone[name=?]', "coupon[to_phone]")
      with_tag('input#coupon_to_address[name=?]', "coupon[to_address]")
      with_tag('input#coupon_from_name[name=?]', "coupon[from_name]")
      with_tag('input#coupon_from_email[name=?]', "coupon[from_email]")
      with_tag('input#coupon_from_phone[name=?]', "coupon[from_phone]")
      with_tag('input#coupon_from_address[name=?]', "coupon[from_address]")
      with_tag('textarea#coupon_message[name=?]', "coupon[message]")
      with_tag('input#coupon_coupon_type[name=?]', "coupon[coupon_type]")
      with_tag('input#coupon_payment_id[name=?]', "coupon[payment_id]")
      with_tag('input#coupon_payment_type[name=?]', "coupon[payment_type]")
    end
  end
end
