class BookingsController < ApplicationController
  include PaymentControllerModule

  def show
    @booking = Booking.active.find_by_token(params[:id])

    respond_to do |format|
      format.html { 
        if @booking
          render :template => "/#{@booking.booker.class.name.tableize}/reciept"
        end
      }
      format.xml  { render :xml => @booking }
    end
  end
  
  def destroy
    @booking = Booking.active.find_by_token(params[:id])
    @booking.update_attribute(:status, Status::DISABLED)

    respond_to do |format|
      format.html { render :template => "/#{@booking.booker.class.name.tableize}/destroy" }
      format.xml  { head :ok }
    end
  end
  
  def book
    @booking = @booker.bookings.build(:participant => Participant.new )
    @user_gift_certificate = UserGiftCertificate.find_by_token(params[:user_gift_certificate_id])
    if request.get?
      if @user_gift_certificate
        @booking.participant.name = @user_gift_certificate.to_name
        @booking.participant.email = @user_gift_certificate.to_email
        @booking.participant.phone = @user_gift_certificate.to_phone
      end
      respond_to do |format|
        format.html
      end
    else
      @booking.attributes = params[:booking]
      @booking.status = Status::ACTIVE
      if @user_gift_certificate
        @booking.payment ||= Payment.new
        @booking.payment.update_attributes(:reciept => @user_gift_certificate, :value => @user_gift_certificate.gift_certificate.value)
      end
      respond_to do |format|
        if @booking.save
          flash[:notice] = 'Bokningen är sparad.'
          format.html { redirect_to @booking }
          format.xml  { render :xml => @booking, :status => :created, :location => @booking }
        else
          flash[:error] = 'Bokningen kunde inte sparas.'
          format.html { render :book }
          format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
end
