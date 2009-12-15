require 'spec_helper'

describe UserGiftCertificatesController do

  def mock_user_gift_certificate(stubs={})
    @mock_user_gift_certificate ||= mock_model(UserGiftCertificate, stubs)
  end

  describe "GET index" do
    it "assigns all user_gift_certificates as @user_gift_certificates" do
      UserGiftCertificate.stub!(:find).with(:all).and_return([mock_user_gift_certificate])
      get :index
      assigns[:user_gift_certificates].should == [mock_user_gift_certificate]
    end
  end

  describe "GET show" do
    it "assigns the requested user_gift_certificate as @user_gift_certificate" do
      UserGiftCertificate.stub!(:find).with("37").and_return(mock_user_gift_certificate)
      get :show, :id => "37"
      assigns[:user_gift_certificate].should equal(mock_user_gift_certificate)
    end
  end

  describe "GET new" do
    it "assigns a new user_gift_certificate as @user_gift_certificate" do
      UserGiftCertificate.stub!(:new).and_return(mock_user_gift_certificate)
      get :new
      assigns[:user_gift_certificate].should equal(mock_user_gift_certificate)
    end
  end

  describe "GET edit" do
    it "assigns the requested user_gift_certificate as @user_gift_certificate" do
      UserGiftCertificate.stub!(:find).with("37").and_return(mock_user_gift_certificate)
      get :edit, :id => "37"
      assigns[:user_gift_certificate].should equal(mock_user_gift_certificate)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created user_gift_certificate as @user_gift_certificate" do
        UserGiftCertificate.stub!(:new).with({'these' => 'params'}).and_return(mock_user_gift_certificate(:save => true))
        post :create, :user_gift_certificate => {:these => 'params'}
        assigns[:user_gift_certificate].should equal(mock_user_gift_certificate)
      end

      it "redirects to the created user_gift_certificate" do
        UserGiftCertificate.stub!(:new).and_return(mock_user_gift_certificate(:save => true))
        post :create, :user_gift_certificate => {}
        response.should redirect_to(user_gift_certificate_url(mock_user_gift_certificate))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user_gift_certificate as @user_gift_certificate" do
        UserGiftCertificate.stub!(:new).with({'these' => 'params'}).and_return(mock_user_gift_certificate(:save => false))
        post :create, :user_gift_certificate => {:these => 'params'}
        assigns[:user_gift_certificate].should equal(mock_user_gift_certificate)
      end

      it "re-renders the 'new' template" do
        UserGiftCertificate.stub!(:new).and_return(mock_user_gift_certificate(:save => false))
        post :create, :user_gift_certificate => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested user_gift_certificate" do
        UserGiftCertificate.should_receive(:find).with("37").and_return(mock_user_gift_certificate)
        mock_user_gift_certificate.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user_gift_certificate => {:these => 'params'}
      end

      it "assigns the requested user_gift_certificate as @user_gift_certificate" do
        UserGiftCertificate.stub!(:find).and_return(mock_user_gift_certificate(:update_attributes => true))
        put :update, :id => "1"
        assigns[:user_gift_certificate].should equal(mock_user_gift_certificate)
      end

      it "redirects to the user_gift_certificate" do
        UserGiftCertificate.stub!(:find).and_return(mock_user_gift_certificate(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(user_gift_certificate_url(mock_user_gift_certificate))
      end
    end

    describe "with invalid params" do
      it "updates the requested user_gift_certificate" do
        UserGiftCertificate.should_receive(:find).with("37").and_return(mock_user_gift_certificate)
        mock_user_gift_certificate.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user_gift_certificate => {:these => 'params'}
      end

      it "assigns the user_gift_certificate as @user_gift_certificate" do
        UserGiftCertificate.stub!(:find).and_return(mock_user_gift_certificate(:update_attributes => false))
        put :update, :id => "1"
        assigns[:user_gift_certificate].should equal(mock_user_gift_certificate)
      end

      it "re-renders the 'edit' template" do
        UserGiftCertificate.stub!(:find).and_return(mock_user_gift_certificate(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested user_gift_certificate" do
      UserGiftCertificate.should_receive(:find).with("37").and_return(mock_user_gift_certificate)
      mock_user_gift_certificate.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the user_gift_certificates list" do
      UserGiftCertificate.stub!(:find).and_return(mock_user_gift_certificate(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(user_gift_certificates_url)
    end
  end

end
