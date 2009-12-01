class BookingsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [ :paypal_ipn, :paypal_success, :paypal_cancel ]

  def show
    @booking = Booking.find_by_token(params[:id])

    respond_to do |format|
      format.html { render :template => "/#{@booking.booker.class.name.tableize}/booking"}
      format.xml  { render :xml => @booking }
    end
  end
  
  def destroy
    @booking = Booking.find_by_token(params[:id])
    @booking.update_attribute(:status, Status::DISABLED)

    respond_to do |format|
      flash[:notice] = 'Bokningen är borttagen.'
      format.html { redirect_to(polymorphic_url(@booking.booker)) }
      format.xml  { head :ok }
    end
  end
  
  def book
    @booking = @booker.bookings.build(:participant => Participant.new )
    if request.get?
      respond_to do |format|
        format.html
      end
    else
      @booking.attributes = params[:booking]
      respond_to do |format|
        if @booking.save
          flash[:notice] = 'Bokningen är sparad.'
          format.html { render :booked }
          format.xml  { render :xml => @booking, :status => :created, :location => @booking }
        else
          flash[:error] = 'Bokningen kunde inte sparas.'
          format.html { render :book }
          format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  def paypal_ipn
    notify = Paypal::Notification.new(request.raw_post)
    if notify.acknowledge 
      if notify.complete?
        @booking = Booking.find(notify.item_id)
        @booking.create_payment(
          :transaction_id => notify.transaction_id,
          :gross          => notify.gross         ,
          :fee            => notify.fee           ,
          :currency       => notify.currency      ,
          :item_name      => notify.item_name     ,
          :status         => notify.status        ,
          :type           => notify.type          ,
          :custom         => notify.custom        ,
          :pending_reason => notify.pending_reason,
          :reason_code    => notify.reason_code   ,
          :memo           => notify.memo          ,
          :payment_type   => notify.payment_type  ,
          :exchange_rate  => notify.exchange_rate ,
          :received_at    => notify.received_at
        )
        @booking.save
        return head(:created)
      end
    end
    return head(:bad_request)
  end
  
  def paypal_success
    @booking = Booking.find_by_token(params[:id])
    if @booking.payment
      flash[:notice] = "Din betalning har motagits"
    else
      flash[:notice] = "Betalningen kunde inte genomföras. Ditt konto har inte blivit krediterat. Du kan antinge prova igen, eller betala till vårat bankgiro."
     end 
    redirect_to booking_path(@booking)
  end
  
  def paypal_cancel
    @booking = Booking.find_by_token(params[:id])
    flash[:notice] = "Din betalning har avbrutits"
    redirect_to booking_path(@booking)
  end
  
end
