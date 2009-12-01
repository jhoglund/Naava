require 'spec_helper'

describe "/bookings/index.html.erb" do
  include BookingsHelper

  before(:each) do
    assigns[:bookings] = [
      stub_model(Booking,
        :booker => ,
        :user => 1
      ),
      stub_model(Booking,
        :booker => ,
        :user => 1
      )
    ]
  end

  it "renders a list of bookings" do
    render
    response.should have_tag("tr>td", .to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
