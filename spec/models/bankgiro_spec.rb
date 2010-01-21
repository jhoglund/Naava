require 'spec_helper'

describe Bankgiro do
  before(:each) do
    @valid_attributes = {
      :avinr => 1,
      :payment_id => 1,
      :gross => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Bankgiro.create!(@valid_attributes)
  end
end
