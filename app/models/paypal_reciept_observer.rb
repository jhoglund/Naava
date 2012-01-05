class PaypalRecieptObserver < ActiveRecord::Observer
  
  def after_create(reciept)
    booking = reciept.item
    if booking.email
      Notification.deliver_mail("Vi har motagit betalning för din bokning för #{booking.booker.name}", booking.email, booking, get_template(booking, 'reciept'))
    end
  end
  
  private
  
  def get_template booking, file_name
    File.join(RAILS_ROOT,'app','views',booking.booker.class.name.tableize,"#{file_name}.text.plain.haml")
  end
  
end
