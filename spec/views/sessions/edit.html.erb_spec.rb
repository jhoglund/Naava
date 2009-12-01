require 'spec_helper'

describe "/sessions/edit.html.erb" do
  include SessionsHelper

  before(:each) do
    assigns[:session] = @session = stub_model(Session,
      :new_record? => false,
      :cource => 1
    )
  end

  it "renders the edit session form" do
    render

    response.should have_tag("form[action=#{session_path(@session)}][method=post]") do
      with_tag('input#session_cource[name=?]', "session[cource]")
    end
  end
end
