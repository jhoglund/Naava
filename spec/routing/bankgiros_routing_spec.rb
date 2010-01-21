require 'spec_helper'

describe BankgirosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/bankgiros" }.should route_to(:controller => "bankgiros", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/bankgiros/new" }.should route_to(:controller => "bankgiros", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/bankgiros/1" }.should route_to(:controller => "bankgiros", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/bankgiros/1/edit" }.should route_to(:controller => "bankgiros", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/bankgiros" }.should route_to(:controller => "bankgiros", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/bankgiros/1" }.should route_to(:controller => "bankgiros", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/bankgiros/1" }.should route_to(:controller => "bankgiros", :action => "destroy", :id => "1") 
    end
  end
end
