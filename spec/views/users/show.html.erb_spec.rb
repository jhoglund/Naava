require 'spec_helper'

describe "/users/show.html.erb" do
  include UsersHelper
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone",
      :login => "value for login"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ email/)
    response.should have_text(/value\ for\ phone/)
    response.should have_text(/value\ for\ login/)
  end
end
