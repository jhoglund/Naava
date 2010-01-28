require 'spec_helper'

describe Attendant do
  before(:each) do
    @valid_attributes = {
      :participant_id => 1,
      :session_id => 1,
      :status => 1,
      :comment => "value for comment"
    }
  end

  it "should create a new instance given valid attributes" do
    Attendant.create!(@valid_attributes)
  end
end
