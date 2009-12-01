require 'spec_helper'

describe "/bookings/edit.html.erb" do
  include BookingsHelper

  before(:each) do
    assigns[:booking] = @booking = stub_model(Booking,
      :new_record? => false,
      :booker => ,
      :user => 1
    )
  end

  it "renders the edit booking form" do
    render

    response.should have_tag("form[action=#{booking_path(@booking)}][method=post]") do
      with_tag('input#booking_booker[name=?]', "booking[booker]")
      with_tag('input#booking_user[name=?]', "booking[user]")
    end
  end
end
