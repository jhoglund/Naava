require 'spec_helper'

describe BookingsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/bookings" }.should route_to(:controller => "bookings", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/bookings/new" }.should route_to(:controller => "bookings", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/bookings/1" }.should route_to(:controller => "bookings", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/bookings/1/edit" }.should route_to(:controller => "bookings", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/bookings" }.should route_to(:controller => "bookings", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/bookings/1" }.should route_to(:controller => "bookings", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/bookings/1" }.should route_to(:controller => "bookings", :action => "destroy", :id => "1") 
    end
  end
end
