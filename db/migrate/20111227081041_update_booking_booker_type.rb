class UpdateBookingBookerType < ActiveRecord::Migration
  def self.up
    Booking.update_all('booker_type = "CourseType"', 'booker_type = "Course"')
  end

  def self.down
    Booking.update_all('booker_type = "Course"', 'booker_type = "CourseType"')
  end
end
