require 'spec_helper'

describe GiftCertificatesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/gift_certificates" }.should route_to(:controller => "gift_certificates", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/gift_certificates/new" }.should route_to(:controller => "gift_certificates", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/gift_certificates/1" }.should route_to(:controller => "gift_certificates", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/gift_certificates/1/edit" }.should route_to(:controller => "gift_certificates", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/gift_certificates" }.should route_to(:controller => "gift_certificates", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/gift_certificates/1" }.should route_to(:controller => "gift_certificates", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/gift_certificates/1" }.should route_to(:controller => "gift_certificates", :action => "destroy", :id => "1") 
    end
  end
end
