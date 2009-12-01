require 'spec_helper'

describe Participant do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone"
    }
  end

  it "should create a new instance given valid attributes" do
    Participant.create!(@valid_attributes)
  end
end
