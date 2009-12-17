require 'spec_helper'

describe CouponTypesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/coupon_types" }.should route_to(:controller => "coupon_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/coupon_types/new" }.should route_to(:controller => "coupon_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/coupon_types/1" }.should route_to(:controller => "coupon_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/coupon_types/1/edit" }.should route_to(:controller => "coupon_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/coupon_types" }.should route_to(:controller => "coupon_types", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/coupon_types/1" }.should route_to(:controller => "coupon_types", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/coupon_types/1" }.should route_to(:controller => "coupon_types", :action => "destroy", :id => "1") 
    end
  end
end
