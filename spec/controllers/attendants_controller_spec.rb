require 'spec_helper'

describe AttendantsController do

  def mock_attendant(stubs={})
    @mock_attendant ||= mock_model(Attendant, stubs)
  end

  describe "GET index" do
    it "assigns all attendants as @attendants" do
      Attendant.stub!(:find).with(:all).and_return([mock_attendant])
      get :index
      assigns[:attendants].should == [mock_attendant]
    end
  end

  describe "GET show" do
    it "assigns the requested attendant as @attendant" do
      Attendant.stub!(:find).with("37").and_return(mock_attendant)
      get :show, :id => "37"
      assigns[:attendant].should equal(mock_attendant)
    end
  end

  describe "GET new" do
    it "assigns a new attendant as @attendant" do
      Attendant.stub!(:new).and_return(mock_attendant)
      get :new
      assigns[:attendant].should equal(mock_attendant)
    end
  end

  describe "GET edit" do
    it "assigns the requested attendant as @attendant" do
      Attendant.stub!(:find).with("37").and_return(mock_attendant)
      get :edit, :id => "37"
      assigns[:attendant].should equal(mock_attendant)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created attendant as @attendant" do
        Attendant.stub!(:new).with({'these' => 'params'}).and_return(mock_attendant(:save => true))
        post :create, :attendant => {:these => 'params'}
        assigns[:attendant].should equal(mock_attendant)
      end

      it "redirects to the created attendant" do
        Attendant.stub!(:new).and_return(mock_attendant(:save => true))
        post :create, :attendant => {}
        response.should redirect_to(attendant_url(mock_attendant))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved attendant as @attendant" do
        Attendant.stub!(:new).with({'these' => 'params'}).and_return(mock_attendant(:save => false))
        post :create, :attendant => {:these => 'params'}
        assigns[:attendant].should equal(mock_attendant)
      end

      it "re-renders the 'new' template" do
        Attendant.stub!(:new).and_return(mock_attendant(:save => false))
        post :create, :attendant => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested attendant" do
        Attendant.should_receive(:find).with("37").and_return(mock_attendant)
        mock_attendant.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :attendant => {:these => 'params'}
      end

      it "assigns the requested attendant as @attendant" do
        Attendant.stub!(:find).and_return(mock_attendant(:update_attributes => true))
        put :update, :id => "1"
        assigns[:attendant].should equal(mock_attendant)
      end

      it "redirects to the attendant" do
        Attendant.stub!(:find).and_return(mock_attendant(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(attendant_url(mock_attendant))
      end
    end

    describe "with invalid params" do
      it "updates the requested attendant" do
        Attendant.should_receive(:find).with("37").and_return(mock_attendant)
        mock_attendant.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :attendant => {:these => 'params'}
      end

      it "assigns the attendant as @attendant" do
        Attendant.stub!(:find).and_return(mock_attendant(:update_attributes => false))
        put :update, :id => "1"
        assigns[:attendant].should equal(mock_attendant)
      end

      it "re-renders the 'edit' template" do
        Attendant.stub!(:find).and_return(mock_attendant(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested attendant" do
      Attendant.should_receive(:find).with("37").and_return(mock_attendant)
      mock_attendant.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the attendants list" do
      Attendant.stub!(:find).and_return(mock_attendant(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(attendants_url)
    end
  end

end
