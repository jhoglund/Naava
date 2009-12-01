require 'spec_helper'

describe "/bookings/new.html.erb" do
  include BookingsHelper

  before(:each) do
    assigns[:booking] = stub_model(Booking,
      :new_record? => true,
      :booker => ,
      :user => 1
    )
  end

  it "renders new booking form" do
    render

    response.should have_tag("form[action=?][method=post]", bookings_path) do
      with_tag("input#booking_booker[name=?]", "booking[booker]")
      with_tag("input#booking_user[name=?]", "booking[user]")
    end
  end
end
