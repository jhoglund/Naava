class Admin::PaymentsController < Admin::AdminController
  before_filter :set_show_paid
  def index
    @payments = Payment.send(params[:show_payment].to_sym).by_id(:desc).paginate(:page => params[:page])

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
        format.html { redirect_to(admin_payment_url(@payment, :show_payment => params[:show_payment])) }
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
        flash[:notice] = 'PaymentReciept was successfully updated.'
        format.html { redirect_to(admin_payments_url(:page => params[:page], :show_payment => params[:show_payment])) }
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
      format.html { redirect_to(admin_payments_url(:page => params[:page], :show_payment => params[:show_payment])) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def set_show_paid
    params[:show_payment] = params[:show_payment] || 'paid_or_not'
  end
end
