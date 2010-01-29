require 'spec_helper'

describe Cash do
  before(:each) do
    @valid_attributes = {
      :gross => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Cash.create!(@valid_attributes)
  end
end
