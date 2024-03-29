require 'spec_helper'

describe SessionsController do

  def mock_session(stubs={})
    @mock_session ||= mock_model(Session, stubs)
  end

  describe "GET index" do
    it "assigns all sessions as @sessions" do
      Session.stub!(:find).with(:all).and_return([mock_session])
      get :index
      assigns[:sessions].should == [mock_session]
    end
  end

  describe "GET show" do
    it "assigns the requested session as @session" do
      Session.stub!(:find).with("37").and_return(mock_session)
      get :show, :id => "37"
      assigns[:session].should equal(mock_session)
    end
  end

  describe "GET new" do
    it "assigns a new session as @session" do
      Session.stub!(:new).and_return(mock_session)
      get :new
      assigns[:session].should equal(mock_session)
    end
  end

  describe "GET edit" do
    it "assigns the requested session as @session" do
      Session.stub!(:find).with("37").and_return(mock_session)
      get :edit, :id => "37"
      assigns[:session].should equal(mock_session)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created session as @session" do
        Session.stub!(:new).with({'these' => 'params'}).and_return(mock_session(:save => true))
        post :create, :session => {:these => 'params'}
        assigns[:session].should equal(mock_session)
      end

      it "redirects to the created session" do
        Session.stub!(:new).and_return(mock_session(:save => true))
        post :create, :session => {}
        response.should redirect_to(session_url(mock_session))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved session as @session" do
        Session.stub!(:new).with({'these' => 'params'}).and_return(mock_session(:save => false))
        post :create, :session => {:these => 'params'}
        assigns[:session].should equal(mock_session)
      end

      it "re-renders the 'new' template" do
        Session.stub!(:new).and_return(mock_session(:save => false))
        post :create, :session => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested session" do
        Session.should_receive(:find).with("37").and_return(mock_session)
        mock_session.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :session => {:these => 'params'}
      end

      it "assigns the requested session as @session" do
        Session.stub!(:find).and_return(mock_session(:update_attributes => true))
        put :update, :id => "1"
        assigns[:session].should equal(mock_session)
      end

      it "redirects to the session" do
        Session.stub!(:find).and_return(mock_session(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(session_url(mock_session))
      end
    end

    describe "with invalid params" do
      it "updates the requested session" do
        Session.should_receive(:find).with("37").and_return(mock_session)
        mock_session.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :session => {:these => 'params'}
      end

      it "assigns the session as @session" do
        Session.stub!(:find).and_return(mock_session(:update_attributes => false))
        put :update, :id => "1"
        assigns[:session].should equal(mock_session)
      end

      it "re-renders the 'edit' template" do
        Session.stub!(:find).and_return(mock_session(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested session" do
      Session.should_receive(:find).with("37").and_return(mock_session)
      mock_session.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the sessions list" do
      Session.stub!(:find).and_return(mock_session(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(sessions_url)
    end
  end

end
