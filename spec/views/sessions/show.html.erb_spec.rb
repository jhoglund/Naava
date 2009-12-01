require 'spec_helper'

describe "/sessions/show.html.erb" do
  include SessionsHelper
  before(:each) do
    assigns[:session] = @session = stub_model(Session,
      :cource => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
  end
end
