require 'spec_helper'

describe Course do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :teatcher => "value for teatcher",
      :level => "value for level"
    }
  end

  it "should create a new instance given valid attributes" do
    Course.create!(@valid_attributes)
  end
end
