require 'spec_helper'

describe "/bookings/show.html.erb" do
  include BookingsHelper
  before(:each) do
    assigns[:booking] = @booking = stub_model(Booking,
      :booker => ,
      :user => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(//)
    response.should have_text(/1/)
  end
end
