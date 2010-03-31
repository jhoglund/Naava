class Admin::PaymentsController < Admin::AdminController

  def index
    @payments = Payment.by_id.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payments }
    end
  end

  def show
    @payment = Payment.find_by_token(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment }
    end
  end

  def new
    @payment = Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment }
    end
  end

  def edit
    @payment = Payment.find_by_token(params[:id])
  end

  def create
    @payment = Payment.new(params[:id])

    respond_to do |format|
      if @payment.save
        flash[:notice] = 'PaymentReciept was successfully created.'
        format.html { redirect_to(admin_payment_url(@payment)) }
        format.xml  { render :xml => @payment, :status => :created, :location => @payment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @payment = Payment.find_by_token(params[:id])
    @payment.notify_by_mail = params[:notify_by_mail] == '1'
    respond_to do |format|
      
      if @payment.update_attributes(params[:payment])
        if params[:payment_type] == 'bg'
          @payment.reciept = Bankgiro.create(:avinr => params[:avinr], :gross => params[:gross]) 
          @payment.value = @payment.reciept.gross
        elsif params[:payment_type] == 'cash'
          @payment.reciept = Cash.create(:gross => params[:cash]) 
          @payment.value = @payment.reciept.gross
        elsif params[:payment_type] == 'free'
          @payment.reciept = Free.create(:note => params[:free_note])
        else
          @payment.reciept.destroy
        end
        @payment.save
        flash[:notice] = 'PaymentReciept was successfully updated.'
        format.html { redirect_to(admin_payment_url(@payment)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment = Payment.find_by_token(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to(admin_payments_url) }
      format.xml  { head :ok }
    end
  end
end
