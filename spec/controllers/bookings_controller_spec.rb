require 'spec_helper'

describe BookingsController do

  def mock_booking(stubs={})
    @mock_booking ||= mock_model(Booking, stubs)
  end

  describe "GET index" do
    it "assigns all bookings as @bookings" do
      Booking.stub!(:find).with(:all).and_return([mock_booking])
      get :index
      assigns[:bookings].should == [mock_booking]
    end
  end

  describe "GET show" do
    it "assigns the requested booking as @booking" do
      Booking.stub!(:find).with("37").and_return(mock_booking)
      get :show, :id => "37"
      assigns[:booking].should equal(mock_booking)
    end
  end

  describe "GET new" do
    it "assigns a new booking as @booking" do
      Booking.stub!(:new).and_return(mock_booking)
      get :new
      assigns[:booking].should equal(mock_booking)
    end
  end

  describe "GET edit" do
    it "assigns the requested booking as @booking" do
      Booking.stub!(:find).with("37").and_return(mock_booking)
      get :edit, :id => "37"
      assigns[:booking].should equal(mock_booking)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created booking as @booking" do
        Booking.stub!(:new).with({'these' => 'params'}).and_return(mock_booking(:save => true))
        post :create, :booking => {:these => 'params'}
        assigns[:booking].should equal(mock_booking)
      end

      it "redirects to the created booking" do
        Booking.stub!(:new).and_return(mock_booking(:save => true))
        post :create, :booking => {}
        response.should redirect_to(booking_url(mock_booking))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved booking as @booking" do
        Booking.stub!(:new).with({'these' => 'params'}).and_return(mock_booking(:save => false))
        post :create, :booking => {:these => 'params'}
        assigns[:booking].should equal(mock_booking)
      end

      it "re-renders the 'new' template" do
        Booking.stub!(:new).and_return(mock_booking(:save => false))
        post :create, :booking => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested booking" do
        Booking.should_receive(:find).with("37").and_return(mock_booking)
        mock_booking.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :booking => {:these => 'params'}
      end

      it "assigns the requested booking as @booking" do
        Booking.stub!(:find).and_return(mock_booking(:update_attributes => true))
        put :update, :id => "1"
        assigns[:booking].should equal(mock_booking)
      end

      it "redirects to the booking" do
        Booking.stub!(:find).and_return(mock_booking(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(booking_url(mock_booking))
      end
    end

    describe "with invalid params" do
      it "updates the requested booking" do
        Booking.should_receive(:find).with("37").and_return(mock_booking)
        mock_booking.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :booking => {:these => 'params'}
      end

      it "assigns the booking as @booking" do
        Booking.stub!(:find).and_return(mock_booking(:update_attributes => false))
        put :update, :id => "1"
        assigns[:booking].should equal(mock_booking)
      end

      it "re-renders the 'edit' template" do
        Booking.stub!(:find).and_return(mock_booking(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested booking" do
      Booking.should_receive(:find).with("37").and_return(mock_booking)
      mock_booking.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the bookings list" do
      Booking.stub!(:find).and_return(mock_booking(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(bookings_url)
    end
  end

end
