require 'spec_helper'

describe GiftCertificatesController do

  def mock_gift_certificate(stubs={})
    @mock_gift_certificate ||= mock_model(GiftCertificate, stubs)
  end

  describe "GET index" do
    it "assigns all gift_certificates as @gift_certificates" do
      GiftCertificate.stub!(:find).with(:all).and_return([mock_gift_certificate])
      get :index
      assigns[:gift_certificates].should == [mock_gift_certificate]
    end
  end

  describe "GET show" do
    it "assigns the requested gift_certificate as @gift_certificate" do
      GiftCertificate.stub!(:find).with("37").and_return(mock_gift_certificate)
      get :show, :id => "37"
      assigns[:gift_certificate].should equal(mock_gift_certificate)
    end
  end

  describe "GET new" do
    it "assigns a new gift_certificate as @gift_certificate" do
      GiftCertificate.stub!(:new).and_return(mock_gift_certificate)
      get :new
      assigns[:gift_certificate].should equal(mock_gift_certificate)
    end
  end

  describe "GET edit" do
    it "assigns the requested gift_certificate as @gift_certificate" do
      GiftCertificate.stub!(:find).with("37").and_return(mock_gift_certificate)
      get :edit, :id => "37"
      assigns[:gift_certificate].should equal(mock_gift_certificate)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created gift_certificate as @gift_certificate" do
        GiftCertificate.stub!(:new).with({'these' => 'params'}).and_return(mock_gift_certificate(:save => true))
        post :create, :gift_certificate => {:these => 'params'}
        assigns[:gift_certificate].should equal(mock_gift_certificate)
      end

      it "redirects to the created gift_certificate" do
        GiftCertificate.stub!(:new).and_return(mock_gift_certificate(:save => true))
        post :create, :gift_certificate => {}
        response.should redirect_to(gift_certificate_url(mock_gift_certificate))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved gift_certificate as @gift_certificate" do
        GiftCertificate.stub!(:new).with({'these' => 'params'}).and_return(mock_gift_certificate(:save => false))
        post :create, :gift_certificate => {:these => 'params'}
        assigns[:gift_certificate].should equal(mock_gift_certificate)
      end

      it "re-renders the 'new' template" do
        GiftCertificate.stub!(:new).and_return(mock_gift_certificate(:save => false))
        post :create, :gift_certificate => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested gift_certificate" do
        GiftCertificate.should_receive(:find).with("37").and_return(mock_gift_certificate)
        mock_gift_certificate.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :gift_certificate => {:these => 'params'}
      end

      it "assigns the requested gift_certificate as @gift_certificate" do
        GiftCertificate.stub!(:find).and_return(mock_gift_certificate(:update_attributes => true))
        put :update, :id => "1"
        assigns[:gift_certificate].should equal(mock_gift_certificate)
      end

      it "redirects to the gift_certificate" do
        GiftCertificate.stub!(:find).and_return(mock_gift_certificate(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(gift_certificate_url(mock_gift_certificate))
      end
    end

    describe "with invalid params" do
      it "updates the requested gift_certificate" do
        GiftCertificate.should_receive(:find).with("37").and_return(mock_gift_certificate)
        mock_gift_certificate.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :gift_certificate => {:these => 'params'}
      end

      it "assigns the gift_certificate as @gift_certificate" do
        GiftCertificate.stub!(:find).and_return(mock_gift_certificate(:update_attributes => false))
        put :update, :id => "1"
        assigns[:gift_certificate].should equal(mock_gift_certificate)
      end

      it "re-renders the 'edit' template" do
        GiftCertificate.stub!(:find).and_return(mock_gift_certificate(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested gift_certificate" do
      GiftCertificate.should_receive(:find).with("37").and_return(mock_gift_certificate)
      mock_gift_certificate.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the gift_certificates list" do
      GiftCertificate.stub!(:find).and_return(mock_gift_certificate(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(gift_certificates_url)
    end
  end

end
