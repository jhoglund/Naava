require 'spec_helper'

describe AttendantsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/attendants" }.should route_to(:controller => "attendants", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/attendants/new" }.should route_to(:controller => "attendants", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/attendants/1" }.should route_to(:controller => "attendants", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/attendants/1/edit" }.should route_to(:controller => "attendants", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/attendants" }.should route_to(:controller => "attendants", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/attendants/1" }.should route_to(:controller => "attendants", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/attendants/1" }.should route_to(:controller => "attendants", :action => "destroy", :id => "1") 
    end
  end
end
