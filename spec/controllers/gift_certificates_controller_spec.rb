require 'spec_helper'

describe CouponTypesController do

  def mock_coupon_type(stubs={})
    @mock_coupon_type ||= mock_model(CouponType, stubs)
  end

  describe "GET index" do
    it "assigns all coupon_types as @coupon_types" do
      CouponType.stub!(:find).with(:all).and_return([mock_coupon_type])
      get :index
      assigns[:coupon_types].should == [mock_coupon_type]
    end
  end

  describe "GET show" do
    it "assigns the requested coupon_type as @coupon_type" do
      CouponType.stub!(:find).with("37").and_return(mock_coupon_type)
      get :show, :id => "37"
      assigns[:coupon_type].should equal(mock_coupon_type)
    end
  end

  describe "GET new" do
    it "assigns a new coupon_type as @coupon_type" do
      CouponType.stub!(:new).and_return(mock_coupon_type)
      get :new
      assigns[:coupon_type].should equal(mock_coupon_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested coupon_type as @coupon_type" do
      CouponType.stub!(:find).with("37").and_return(mock_coupon_type)
      get :edit, :id => "37"
      assigns[:coupon_type].should equal(mock_coupon_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created coupon_type as @coupon_type" do
        CouponType.stub!(:new).with({'these' => 'params'}).and_return(mock_coupon_type(:save => true))
        post :create, :coupon_type => {:these => 'params'}
        assigns[:coupon_type].should equal(mock_coupon_type)
      end

      it "redirects to the created coupon_type" do
        CouponType.stub!(:new).and_return(mock_coupon_type(:save => true))
        post :create, :coupon_type => {}
        response.should redirect_to(coupon_type_url(mock_coupon_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved coupon_type as @coupon_type" do
        CouponType.stub!(:new).with({'these' => 'params'}).and_return(mock_coupon_type(:save => false))
        post :create, :coupon_type => {:these => 'params'}
        assigns[:coupon_type].should equal(mock_coupon_type)
      end

      it "re-renders the 'new' template" do
        CouponType.stub!(:new).and_return(mock_coupon_type(:save => false))
        post :create, :coupon_type => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested coupon_type" do
        CouponType.should_receive(:find).with("37").and_return(mock_coupon_type)
        mock_coupon_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :coupon_type => {:these => 'params'}
      end

      it "assigns the requested coupon_type as @coupon_type" do
        CouponType.stub!(:find).and_return(mock_coupon_type(:update_attributes => true))
        put :update, :id => "1"
        assigns[:coupon_type].should equal(mock_coupon_type)
      end

      it "redirects to the coupon_type" do
        CouponType.stub!(:find).and_return(mock_coupon_type(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(coupon_type_url(mock_coupon_type))
      end
    end

    describe "with invalid params" do
      it "updates the requested coupon_type" do
        CouponType.should_receive(:find).with("37").and_return(mock_coupon_type)
        mock_coupon_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :coupon_type => {:these => 'params'}
      end

      it "assigns the coupon_type as @coupon_type" do
        CouponType.stub!(:find).and_return(mock_coupon_type(:update_attributes => false))
        put :update, :id => "1"
        assigns[:coupon_type].should equal(mock_coupon_type)
      end

      it "re-renders the 'edit' template" do
        CouponType.stub!(:find).and_return(mock_coupon_type(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested coupon_type" do
      CouponType.should_receive(:find).with("37").and_return(mock_coupon_type)
      mock_coupon_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the coupon_types list" do
      CouponType.stub!(:find).and_return(mock_coupon_type(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(coupon_types_url)
    end
  end

end
