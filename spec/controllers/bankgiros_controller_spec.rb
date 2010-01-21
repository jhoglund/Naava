require 'spec_helper'

describe BankgirosController do

  def mock_bankgiro(stubs={})
    @mock_bankgiro ||= mock_model(Bankgiro, stubs)
  end

  describe "GET index" do
    it "assigns all bankgiros as @bankgiros" do
      Bankgiro.stub!(:find).with(:all).and_return([mock_bankgiro])
      get :index
      assigns[:bankgiros].should == [mock_bankgiro]
    end
  end

  describe "GET show" do
    it "assigns the requested bankgiro as @bankgiro" do
      Bankgiro.stub!(:find).with("37").and_return(mock_bankgiro)
      get :show, :id => "37"
      assigns[:bankgiro].should equal(mock_bankgiro)
    end
  end

  describe "GET new" do
    it "assigns a new bankgiro as @bankgiro" do
      Bankgiro.stub!(:new).and_return(mock_bankgiro)
      get :new
      assigns[:bankgiro].should equal(mock_bankgiro)
    end
  end

  describe "GET edit" do
    it "assigns the requested bankgiro as @bankgiro" do
      Bankgiro.stub!(:find).with("37").and_return(mock_bankgiro)
      get :edit, :id => "37"
      assigns[:bankgiro].should equal(mock_bankgiro)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created bankgiro as @bankgiro" do
        Bankgiro.stub!(:new).with({'these' => 'params'}).and_return(mock_bankgiro(:save => true))
        post :create, :bankgiro => {:these => 'params'}
        assigns[:bankgiro].should equal(mock_bankgiro)
      end

      it "redirects to the created bankgiro" do
        Bankgiro.stub!(:new).and_return(mock_bankgiro(:save => true))
        post :create, :bankgiro => {}
        response.should redirect_to(bankgiro_url(mock_bankgiro))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bankgiro as @bankgiro" do
        Bankgiro.stub!(:new).with({'these' => 'params'}).and_return(mock_bankgiro(:save => false))
        post :create, :bankgiro => {:these => 'params'}
        assigns[:bankgiro].should equal(mock_bankgiro)
      end

      it "re-renders the 'new' template" do
        Bankgiro.stub!(:new).and_return(mock_bankgiro(:save => false))
        post :create, :bankgiro => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested bankgiro" do
        Bankgiro.should_receive(:find).with("37").and_return(mock_bankgiro)
        mock_bankgiro.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :bankgiro => {:these => 'params'}
      end

      it "assigns the requested bankgiro as @bankgiro" do
        Bankgiro.stub!(:find).and_return(mock_bankgiro(:update_attributes => true))
        put :update, :id => "1"
        assigns[:bankgiro].should equal(mock_bankgiro)
      end

      it "redirects to the bankgiro" do
        Bankgiro.stub!(:find).and_return(mock_bankgiro(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(bankgiro_url(mock_bankgiro))
      end
    end

    describe "with invalid params" do
      it "updates the requested bankgiro" do
        Bankgiro.should_receive(:find).with("37").and_return(mock_bankgiro)
        mock_bankgiro.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :bankgiro => {:these => 'params'}
      end

      it "assigns the bankgiro as @bankgiro" do
        Bankgiro.stub!(:find).and_return(mock_bankgiro(:update_attributes => false))
        put :update, :id => "1"
        assigns[:bankgiro].should equal(mock_bankgiro)
      end

      it "re-renders the 'edit' template" do
        Bankgiro.stub!(:find).and_return(mock_bankgiro(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested bankgiro" do
      Bankgiro.should_receive(:find).with("37").and_return(mock_bankgiro)
      mock_bankgiro.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the bankgiros list" do
      Bankgiro.stub!(:find).and_return(mock_bankgiro(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(bankgiros_url)
    end
  end

end
