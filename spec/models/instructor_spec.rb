require 'spec_helper'

describe Instructor do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone",
      :bio => "value for bio",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Instructor.create!(@valid_attributes)
  end
end
