require 'spec_helper'

describe UserGiftCertificate do
  before(:each) do
    @valid_attributes = {
      :to_name => "value for to_name",
      :to_email => "value for to_email",
      :to_phone => "value for to_phone",
      :to_address => "value for to_address",
      :from_name => "value for from_name",
      :from_email => "value for from_email",
      :from_phone => "value for from_phone",
      :from_address => "value for from_address",
      :message => "value for message",
      :gift_certificate_id => 1,
      :payment_id => 1,
      :payment_type => "value for payment_type"
    }
  end

  it "should create a new instance given valid attributes" do
    UserGiftCertificate.create!(@valid_attributes)
  end
end
