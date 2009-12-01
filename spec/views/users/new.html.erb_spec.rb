require 'spec_helper'

describe "/users/new.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:user] = stub_model(User,
      :new_record? => true,
      :name => "value for name",
      :email => "value for email",
      :phone => "value for phone",
      :login => "value for login"
    )
  end

  it "renders new user form" do
    render

    response.should have_tag("form[action=?][method=post]", users_path) do
      with_tag("input#user_name[name=?]", "user[name]")
      with_tag("input#user_email[name=?]", "user[email]")
      with_tag("input#user_phone[name=?]", "user[phone]")
      with_tag("input#user_login[name=?]", "user[login]")
    end
  end
end
