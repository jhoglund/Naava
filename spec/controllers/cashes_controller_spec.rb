require 'spec_helper'

describe CashesController do

  def mock_cash(stubs={})
    @mock_cash ||= mock_model(Cash, stubs)
  end

  describe "GET index" do
    it "assigns all cashes as @cashes" do
      Cash.stub!(:find).with(:all).and_return([mock_cash])
      get :index
      assigns[:cashes].should == [mock_cash]
    end
  end

  describe "GET show" do
    it "assigns the requested cash as @cash" do
      Cash.stub!(:find).with("37").and_return(mock_cash)
      get :show, :id => "37"
      assigns[:cash].should equal(mock_cash)
    end
  end

  describe "GET new" do
    it "assigns a new cash as @cash" do
      Cash.stub!(:new).and_return(mock_cash)
      get :new
      assigns[:cash].should equal(mock_cash)
    end
  end

  describe "GET edit" do
    it "assigns the requested cash as @cash" do
      Cash.stub!(:find).with("37").and_return(mock_cash)
      get :edit, :id => "37"
      assigns[:cash].should equal(mock_cash)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created cash as @cash" do
        Cash.stub!(:new).with({'these' => 'params'}).and_return(mock_cash(:save => true))
        post :create, :cash => {:these => 'params'}
        assigns[:cash].should equal(mock_cash)
      end

      it "redirects to the created cash" do
        Cash.stub!(:new).and_return(mock_cash(:save => true))
        post :create, :cash => {}
        response.should redirect_to(cash_url(mock_cash))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cash as @cash" do
        Cash.stub!(:new).with({'these' => 'params'}).and_return(mock_cash(:save => false))
        post :create, :cash => {:these => 'params'}
        assigns[:cash].should equal(mock_cash)
      end

      it "re-renders the 'new' template" do
        Cash.stub!(:new).and_return(mock_cash(:save => false))
        post :create, :cash => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested cash" do
        Cash.should_receive(:find).with("37").and_return(mock_cash)
        mock_cash.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :cash => {:these => 'params'}
      end

      it "assigns the requested cash as @cash" do
        Cash.stub!(:find).and_return(mock_cash(:update_attributes => true))
        put :update, :id => "1"
        assigns[:cash].should equal(mock_cash)
      end

      it "redirects to the cash" do
        Cash.stub!(:find).and_return(mock_cash(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(cash_url(mock_cash))
      end
    end

    describe "with invalid params" do
      it "updates the requested cash" do
        Cash.should_receive(:find).with("37").and_return(mock_cash)
        mock_cash.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :cash => {:these => 'params'}
      end

      it "assigns the cash as @cash" do
        Cash.stub!(:find).and_return(mock_cash(:update_attributes => false))
        put :update, :id => "1"
        assigns[:cash].should equal(mock_cash)
      end

      it "re-renders the 'edit' template" do
        Cash.stub!(:find).and_return(mock_cash(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested cash" do
      Cash.should_receive(:find).with("37").and_return(mock_cash)
      mock_cash.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the cashes list" do
      Cash.stub!(:find).and_return(mock_cash(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(cashes_url)
    end
  end

end
