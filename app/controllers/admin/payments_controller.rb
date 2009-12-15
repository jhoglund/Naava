class PaymentsController < ApplicationController
  # GET /payment_reciepts
  # GET /payment_reciepts.xml
  def index
    @payment_reciepts = PaymentReciept.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payment_reciepts }
    end
  end

  # GET /payment_reciepts/1
  # GET /payment_reciepts/1.xml
  def show
    @payment_reciept = PaymentReciept.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment_reciept }
    end
  end

  # GET /payment_reciepts/new
  # GET /payment_reciepts/new.xml
  def new
    @payment_reciept = PaymentReciept.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment_reciept }
    end
  end

  # GET /payment_reciepts/1/edit
  def edit
    @payment_reciept = PaymentReciept.find(params[:id])
  end

  # POST /payment_reciepts
  # POST /payment_reciepts.xml
  def create
    @payment_reciept = PaymentReciept.new(params[:payment_reciept])

    respond_to do |format|
      if @payment_reciept.save
        flash[:notice] = 'PaymentReciept was successfully created.'
        format.html { redirect_to(@payment_reciept) }
        format.xml  { render :xml => @payment_reciept, :status => :created, :location => @payment_reciept }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment_reciept.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payment_reciepts/1
  # PUT /payment_reciepts/1.xml
  def update
    @payment_reciept = PaymentReciept.find(params[:id])

    respond_to do |format|
      if @payment_reciept.update_attributes(params[:payment_reciept])
        flash[:notice] = 'PaymentReciept was successfully updated.'
        format.html { redirect_to(@payment_reciept) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payment_reciept.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_reciepts/1
  # DELETE /payment_reciepts/1.xml
  def destroy
    @payment_reciept = PaymentReciept.find(params[:id])
    @payment_reciept.destroy

    respond_to do |format|
      format.html { redirect_to(payment_reciepts_url) }
      format.xml  { head :ok }
    end
  end
end
