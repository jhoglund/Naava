require 'spec_helper'

describe PaymentReciept do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :email => "value for email",
      :note => "value for note",
      :meta => "value for meta",
      :item_id => 1,
      :item_type => "value for item_type"
    }
  end

  it "should create a new instance given valid attributes" do
    PaymentReciept.create!(@valid_attributes)
  end
end
