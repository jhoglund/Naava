class UserGiftCertificatesController < ApplicationController
  include PaymentControllerModule
  
  def index
    @gift_certificate = UserGiftCertificate.new(:gift_certificate => GiftCertificate.first)
    @gift_certificates = GiftCertificate.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @gift_certificates }
    end
  end
  
  def show
    @user_gift_certificate = UserGiftCertificate.find_by_token(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_gift_certificate }
    end
  end

  def new
    @user_gift_certificate = UserGiftCertificate.new(params[:user_gift_certificate])
    @user_gift_certificate.gift_certificate ||= GiftCertificate.first
     
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user_gift_certificate }
    end
  end


  def edit
    @user_gift_certificate = UserGiftCertificate.find_by_token(params[:id])
  end

  def create
    @user_gift_certificate = UserGiftCertificate.new(params[:user_gift_certificate])

    respond_to do |format|
      if @user_gift_certificate.save
        flash[:notice] = 'UserGiftCertificate was successfully created.'
        format.html { redirect_to(payment_path(@user_gift_certificate.payment)) }
        format.xml  { render :xml => @user_gift_certificate, :status => :created, :location => @user_gift_certificate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_gift_certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user_gift_certificate = UserGiftCertificate.find_by_token(params[:id])

    respond_to do |format|
      if @user_gift_certificate.update_attributes(params[:user_gift_certificate])
        flash[:notice] = 'UserGiftCertificate was successfully updated.'
        format.html { redirect_to(payment_path(@user_gift_certificate.payment)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_gift_certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_gift_certificate = UserGiftCertificate.find_by_token(params[:id])
    @user_gift_certificate.destroy

    respond_to do |format|
      format.html { redirect_to(user_gift_certificates_url) }
      format.xml  { head :ok }
    end
  end
end
