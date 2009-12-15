require 'spec_helper'

describe PaymentRecieptsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/payment_reciepts" }.should route_to(:controller => "payment_reciepts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/payment_reciepts/new" }.should route_to(:controller => "payment_reciepts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/payment_reciepts/1" }.should route_to(:controller => "payment_reciepts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/payment_reciepts/1/edit" }.should route_to(:controller => "payment_reciepts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/payment_reciepts" }.should route_to(:controller => "payment_reciepts", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/payment_reciepts/1" }.should route_to(:controller => "payment_reciepts", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/payment_reciepts/1" }.should route_to(:controller => "payment_reciepts", :action => "destroy", :id => "1") 
    end
  end
end
