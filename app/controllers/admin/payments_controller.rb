class Admin::PaymentsController < Admin::AdminController

  def index
    @payments = Payment.all

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
    respond_to do |format|
      
      if @payment.update_attributes(params[:payment])
        if not params[:avinr].blank? and not params[:gross].blank?
          @payment.reciept = Bankgiro.create(:avinr => params[:avinr], :gross => params[:gross]) 
          @payment.value = @payment.reciept.gross
          @payment.save
        end
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
