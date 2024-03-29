class GiftCertificatesController < ApplicationController
  include PaymentControllerModule
  #caches_page :index
  validates_captcha
  
  def index
    @gift_certificate = GiftCertificate.new(:coupon_type => GiftCertificateType.first)
    @gift_certificate_types = GiftCertificateType.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @coupon_types }
    end
  end
  
  def show
    begin
      @coupon = Coupon.find(:first, :conditions => { :token =>params[:id] })
      respond_to do |format|
        format.html # show.html.haml
        format.xml  { render :xml => @coupon }
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Vi kan inte hitta något presentkort med koden: <strong>#{params[:id]}</strong>"
    end
  end
  
  def print
    @coupon = Coupon.find_by_token(params[:id])
    
    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @coupon }
      format.pdf do
        render :pdf => "presentkort",
               :template => false,
               :layout => false,
               :wkhtmltopdf => Rails.env.production? ? 'xvfb-run -a -s "-screen 0 640x480x16" wkhtmltopdf' : '/usr/local/bin/wkhtmltopdf' # OPTIONAL, path to binary
      end
    end
  end
  

  def new
    @gift_certificate = GiftCertificate.new(:coupon_type_id => params[:coupon_type_id])
    @gift_certificate.coupon_type ||= GiftCertificateType.first
     
    respond_to do |format|
      format.html
      format.xml  { render :xml => @gift_certificate }
    end
  end

  def create
    @gift_certificate = GiftCertificate.new(params[:gift_certificate])
    @gift_certificate.valid_from = DateTime.now
    @gift_certificate.valid_to = 1.year.from_now
    respond_to do |format|
      if captcha_validated?
        if @gift_certificate.save
          flash[:notice] = 'Tack för ditt köp.'
          format.html { redirect_to(payment_path(@gift_certificate.payment)) }
          format.xml  { render :xml => @gift_certificate, :status => :created, :location => @gift_certificate }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @gift_certificate.errors, :status => :unprocessable_entity }
        end
      else
        flash[:error] = 'Texten stämmer inte överens med bilden.'
        format.html { render :action => "new" }
      end
    end
    
  end

end
