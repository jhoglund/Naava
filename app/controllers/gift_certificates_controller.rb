class GiftCertificatesController < ApplicationController
  include PaymentControllerModule
  
  def index
    @gift_certificate = GiftCertificate.new(:coupon_type => GiftCertificateType.first)
    @gift_certificate_types = GiftCertificateType.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @coupon_types }
    end
  end
  
  def show
    @coupon = Coupon.find_by_token(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coupon }
    end
  end

  def new
    @gift_certificate = GiftCertificate.new(params[:gift_certificate])
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
      if @gift_certificate.save
        flash[:notice] = 'Tack för ditt köp.'
        format.html { redirect_to(payment_path(@gift_certificate.payment)) }
        format.xml  { render :xml => @gift_certificate, :status => :created, :location => @gift_certificate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gift_certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

end
