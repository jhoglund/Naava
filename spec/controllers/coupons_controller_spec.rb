require 'spec_helper'

describe CouponsController do

  def mock_coupon(stubs={})
    @mock_coupon ||= mock_model(Coupon, stubs)
  end

  describe "GET index" do
    it "assigns all coupons as @coupons" do
      Coupon.stub!(:find).with(:all).and_return([mock_coupon])
      get :index
      assigns[:coupons].should == [mock_coupon]
    end
  end

  describe "GET show" do
    it "assigns the requested coupon as @coupon" do
      Coupon.stub!(:find).with("37").and_return(mock_coupon)
      get :show, :id => "37"
      assigns[:coupon].should equal(mock_coupon)
    end
  end

  describe "GET new" do
    it "assigns a new coupon as @coupon" do
      Coupon.stub!(:new).and_return(mock_coupon)
      get :new
      assigns[:coupon].should equal(mock_coupon)
    end
  end

  describe "GET edit" do
    it "assigns the requested coupon as @coupon" do
      Coupon.stub!(:find).with("37").and_return(mock_coupon)
      get :edit, :id => "37"
      assigns[:coupon].should equal(mock_coupon)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created coupon as @coupon" do
        Coupon.stub!(:new).with({'these' => 'params'}).and_return(mock_coupon(:save => true))
        post :create, :coupon => {:these => 'params'}
        assigns[:coupon].should equal(mock_coupon)
      end

      it "redirects to the created coupon" do
        Coupon.stub!(:new).and_return(mock_coupon(:save => true))
        post :create, :coupon => {}
        response.should redirect_to(coupon_url(mock_coupon))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved coupon as @coupon" do
        Coupon.stub!(:new).with({'these' => 'params'}).and_return(mock_coupon(:save => false))
        post :create, :coupon => {:these => 'params'}
        assigns[:coupon].should equal(mock_coupon)
      end

      it "re-renders the 'new' template" do
        Coupon.stub!(:new).and_return(mock_coupon(:save => false))
        post :create, :coupon => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested coupon" do
        Coupon.should_receive(:find).with("37").and_return(mock_coupon)
        mock_coupon.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :coupon => {:these => 'params'}
      end

      it "assigns the requested coupon as @coupon" do
        Coupon.stub!(:find).and_return(mock_coupon(:update_attributes => true))
        put :update, :id => "1"
        assigns[:coupon].should equal(mock_coupon)
      end

      it "redirects to the coupon" do
        Coupon.stub!(:find).and_return(mock_coupon(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(coupon_url(mock_coupon))
      end
    end

    describe "with invalid params" do
      it "updates the requested coupon" do
        Coupon.should_receive(:find).with("37").and_return(mock_coupon)
        mock_coupon.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :coupon => {:these => 'params'}
      end

      it "assigns the coupon as @coupon" do
        Coupon.stub!(:find).and_return(mock_coupon(:update_attributes => false))
        put :update, :id => "1"
        assigns[:coupon].should equal(mock_coupon)
      end

      it "re-renders the 'edit' template" do
        Coupon.stub!(:find).and_return(mock_coupon(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested coupon" do
      Coupon.should_receive(:find).with("37").and_return(mock_coupon)
      mock_coupon.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the coupons list" do
      Coupon.stub!(:find).and_return(mock_coupon(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(coupons_url)
    end
  end

end
