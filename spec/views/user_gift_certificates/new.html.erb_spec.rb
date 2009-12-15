require 'spec_helper'

describe "/user_gift_certificates/new.html.erb" do
  include UserGiftCertificatesHelper

  before(:each) do
    assigns[:user_gift_certificate] = stub_model(UserGiftCertificate,
      :new_record? => true,
      :to_name => "value for to_name",
      :to_email => "value for to_email",
      :to_phone => "value for to_phone",
      :to_address => "value for to_address",
      :from_name => "value for from_name",
      :from_email => "value for from_email",
      :from_phone => "value for from_phone",
      :from_address => "value for from_address",
      :message => "value for message",
      :gift_certificate => 1,
      :payment_id => 1,
      :payment_type => "value for payment_type"
    )
  end

  it "renders new user_gift_certificate form" do
    render

    response.should have_tag("form[action=?][method=post]", user_gift_certificates_path) do
      with_tag("input#user_gift_certificate_to_name[name=?]", "user_gift_certificate[to_name]")
      with_tag("input#user_gift_certificate_to_email[name=?]", "user_gift_certificate[to_email]")
      with_tag("input#user_gift_certificate_to_phone[name=?]", "user_gift_certificate[to_phone]")
      with_tag("input#user_gift_certificate_to_address[name=?]", "user_gift_certificate[to_address]")
      with_tag("input#user_gift_certificate_from_name[name=?]", "user_gift_certificate[from_name]")
      with_tag("input#user_gift_certificate_from_email[name=?]", "user_gift_certificate[from_email]")
      with_tag("input#user_gift_certificate_from_phone[name=?]", "user_gift_certificate[from_phone]")
      with_tag("input#user_gift_certificate_from_address[name=?]", "user_gift_certificate[from_address]")
      with_tag("textarea#user_gift_certificate_message[name=?]", "user_gift_certificate[message]")
      with_tag("input#user_gift_certificate_gift_certificate[name=?]", "user_gift_certificate[gift_certificate]")
      with_tag("input#user_gift_certificate_payment_id[name=?]", "user_gift_certificate[payment_id]")
      with_tag("input#user_gift_certificate_payment_type[name=?]", "user_gift_certificate[payment_type]")
    end
  end
end
