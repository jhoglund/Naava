require 'spec_helper'

describe "/sessions/new.html.erb" do
  include SessionsHelper

  before(:each) do
    assigns[:session] = stub_model(Session,
      :new_record? => true,
      :cource => 1
    )
  end

  it "renders new session form" do
    render

    response.should have_tag("form[action=?][method=post]", sessions_path) do
      with_tag("input#session_cource[name=?]", "session[cource]")
    end
  end
end
