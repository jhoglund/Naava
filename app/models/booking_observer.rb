class BookingObserver < ActiveRecord::Observer
  
  def after_create(booking)
    if booking.email
      Notification.deliver_mail("Vi har motagning din bokning för #{booking.booker.name}", booking.email, booking, get_template(booking, 'create'))
    end
  end
  
  def after_update(booking)
    if booking.disabling? and booking.email
      Notification.deliver_mail("Din bokning har blivit borttagen", booking.email, booking, get_template(booking, 'destroy'))
      if booking.payment
        Notification.deliver_mail("Refund needed for #{booking.payment.transaction_id}", AppConfig[:support_mail], booking, get_template(booking, 'refund'))
      end
    end
  end
  
  private
  
  def get_template booking, file_name
    File.join(RAILS_ROOT,'app','views',booking.booker.class.name.tableize,"#{file_name}.text.plain.erb")
  end
  
end
