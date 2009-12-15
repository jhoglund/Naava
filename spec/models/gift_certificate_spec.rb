require 'spec_helper'

describe GiftCertificate do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :value => 1,
      :valid_from => Time.now,
      :valid_to => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    GiftCertificate.create!(@valid_attributes)
  end
end
