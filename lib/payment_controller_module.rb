module PaymentControllerModule

  def self.included(base)
    base.send :skip_before_filter, :verify_authenticity_token, :only => [ :paypal_ipn, :paypal_success, :paypal_cancel ]
  end
  
  
  def paypal_ipn
    notify = Paypal::Notification.new(request.raw_post)
    if notify.acknowledge 
      if notify.complete?
        #begin
          @payment = Payment.find_by_token(notify.item_id)
          @payment.reciept = PaypalReciept.create(
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
          @payment.value = notify.gross
          @payment.save
          return head(:created)
        #rescue
        #  return head(:status => 500)
        #end
      end
    end
    return head(:bad_request)
  end
  
  def paypal_success
    @payment = Payment.find_by_token(params[:id])
    if @payment.paid?
      flash[:notice] = "Din betalning har motagits"
    else
      flash[:error] = "Betalningen kunde inte genomföras. Ditt konto har inte blivit krediterat. Du kan antinge prova igen, eller betala till vårat bankgiro."
     end 
    redirect_to payment_path(@payment)
  end
  
  def paypal_cancel
    @payment = Payment.find_by_token(params[:id])
    flash[:notice] = "Din betalning har avbrutits"
    redirect_to payment_path(@payment)
  end
  
end