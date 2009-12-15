require 'spec_helper'

describe UserGiftCertificatesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/user_gift_certificates" }.should route_to(:controller => "user_gift_certificates", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/user_gift_certificates/new" }.should route_to(:controller => "user_gift_certificates", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/user_gift_certificates/1" }.should route_to(:controller => "user_gift_certificates", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/user_gift_certificates/1/edit" }.should route_to(:controller => "user_gift_certificates", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/user_gift_certificates" }.should route_to(:controller => "user_gift_certificates", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/user_gift_certificates/1" }.should route_to(:controller => "user_gift_certificates", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/user_gift_certificates/1" }.should route_to(:controller => "user_gift_certificates", :action => "destroy", :id => "1") 
    end
  end
end
