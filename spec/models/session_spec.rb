require 'spec_helper'

describe Session do
  before(:each) do
    @valid_attributes = {
      :cource_id => 1,
      :starts_at => Time.now,
      :ends_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Session.create!(@valid_attributes)
  end
end
