require 'spec_helper'

describe CashesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/cashes" }.should route_to(:controller => "cashes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/cashes/new" }.should route_to(:controller => "cashes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/cashes/1" }.should route_to(:controller => "cashes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/cashes/1/edit" }.should route_to(:controller => "cashes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/cashes" }.should route_to(:controller => "cashes", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/cashes/1" }.should route_to(:controller => "cashes", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cashes/1" }.should route_to(:controller => "cashes", :action => "destroy", :id => "1") 
    end
  end
end
