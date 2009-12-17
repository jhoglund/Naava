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
    @coupon = Coupon.find_by_token(params[:coupon_id])
    if request.get?
      if @coupon
        @booking.participant.name = @coupon.to_name
        @booking.participant.email = @coupon.to_email
        @booking.participant.phone = @coupon.to_phone
      end
      respond_to do |format|
        format.html
      end
    else
      @booking.attributes = params[:booking]
      @booking.status = Status::ACTIVE
      respond_to do |format|
        if @booking.save
          if @coupon and params[:pay_with_coupon]
            @booking.payment ||= Payment.new(:item => @booking)
            @booking.payment.update_attributes(:reciept => @coupon, :value => @coupon.coupon_type.value)
          end
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
