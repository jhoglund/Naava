require 'spec_helper'

describe PaymentRecieptsController do

  def mock_payment_reciept(stubs={})
    @mock_payment_reciept ||= mock_model(PaymentReciept, stubs)
  end

  describe "GET index" do
    it "assigns all payment_reciepts as @payment_reciepts" do
      PaymentReciept.stub!(:find).with(:all).and_return([mock_payment_reciept])
      get :index
      assigns[:payment_reciepts].should == [mock_payment_reciept]
    end
  end

  describe "GET show" do
    it "assigns the requested payment_reciept as @payment_reciept" do
      PaymentReciept.stub!(:find).with("37").and_return(mock_payment_reciept)
      get :show, :id => "37"
      assigns[:payment_reciept].should equal(mock_payment_reciept)
    end
  end

  describe "GET new" do
    it "assigns a new payment_reciept as @payment_reciept" do
      PaymentReciept.stub!(:new).and_return(mock_payment_reciept)
      get :new
      assigns[:payment_reciept].should equal(mock_payment_reciept)
    end
  end

  describe "GET edit" do
    it "assigns the requested payment_reciept as @payment_reciept" do
      PaymentReciept.stub!(:find).with("37").and_return(mock_payment_reciept)
      get :edit, :id => "37"
      assigns[:payment_reciept].should equal(mock_payment_reciept)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created payment_reciept as @payment_reciept" do
        PaymentReciept.stub!(:new).with({'these' => 'params'}).and_return(mock_payment_reciept(:save => true))
        post :create, :payment_reciept => {:these => 'params'}
        assigns[:payment_reciept].should equal(mock_payment_reciept)
      end

      it "redirects to the created payment_reciept" do
        PaymentReciept.stub!(:new).and_return(mock_payment_reciept(:save => true))
        post :create, :payment_reciept => {}
        response.should redirect_to(payment_reciept_url(mock_payment_reciept))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved payment_reciept as @payment_reciept" do
        PaymentReciept.stub!(:new).with({'these' => 'params'}).and_return(mock_payment_reciept(:save => false))
        post :create, :payment_reciept => {:these => 'params'}
        assigns[:payment_reciept].should equal(mock_payment_reciept)
      end

      it "re-renders the 'new' template" do
        PaymentReciept.stub!(:new).and_return(mock_payment_reciept(:save => false))
        post :create, :payment_reciept => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested payment_reciept" do
        PaymentReciept.should_receive(:find).with("37").and_return(mock_payment_reciept)
        mock_payment_reciept.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :payment_reciept => {:these => 'params'}
      end

      it "assigns the requested payment_reciept as @payment_reciept" do
        PaymentReciept.stub!(:find).and_return(mock_payment_reciept(:update_attributes => true))
        put :update, :id => "1"
        assigns[:payment_reciept].should equal(mock_payment_reciept)
      end

      it "redirects to the payment_reciept" do
        PaymentReciept.stub!(:find).and_return(mock_payment_reciept(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(payment_reciept_url(mock_payment_reciept))
      end
    end

    describe "with invalid params" do
      it "updates the requested payment_reciept" do
        PaymentReciept.should_receive(:find).with("37").and_return(mock_payment_reciept)
        mock_payment_reciept.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :payment_reciept => {:these => 'params'}
      end

      it "assigns the payment_reciept as @payment_reciept" do
        PaymentReciept.stub!(:find).and_return(mock_payment_reciept(:update_attributes => false))
        put :update, :id => "1"
        assigns[:payment_reciept].should equal(mock_payment_reciept)
      end

      it "re-renders the 'edit' template" do
        PaymentReciept.stub!(:find).and_return(mock_payment_reciept(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested payment_reciept" do
      PaymentReciept.should_receive(:find).with("37").and_return(mock_payment_reciept)
      mock_payment_reciept.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the payment_reciepts list" do
      PaymentReciept.stub!(:find).and_return(mock_payment_reciept(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(payment_reciepts_url)
    end
  end

end
