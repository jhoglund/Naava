require 'spec_helper'

describe Booking do
  before(:each) do
    @valid_attributes = {
      :booker => ,
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Booking.create!(@valid_attributes)
  end
end
