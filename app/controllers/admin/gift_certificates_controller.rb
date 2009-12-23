class Admin::GiftCertificatesController < Admin::AdminController
  def index
    @gift_certificate = GiftCertificate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gift_certificate }
    end
  end

  def show
    @gift_certificate = GiftCertificate.find_by_token(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gift_certificate }
    end
  end

  def new
    @gift_certificate = GiftCertificate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gift_certificate }
    end
  end

  def edit
    @gift_certificate = GiftCertificate.find_by_token(params[:id])
  end

  def create
    @gift_certificate = GiftCertificate.new(params[:gift_certificate])

    respond_to do |format|
      if @gift_certificate.save
        flash[:notice] = 'GiftCertificate was successfully created.'
        format.html { redirect_to(admin_gift_certificate_url(@gift_certificate)) }
        format.xml  { render :xml => @gift_certificate, :status => :created, :location => @gift_certificate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gift_certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @gift_certificate = GiftCertificate.find_by_token(params[:id])

    respond_to do |format|
      if @gift_certificate.update_attributes(params[:gift_certificate])
        flash[:notice] = 'GiftCertificate was successfully updated.'
        format.html { redirect_to(admin_gift_certificate_url(@gift_certificate)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gift_certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @gift_certificate = GiftCertificate.find_by_token(params[:id])
    @gift_certificate.destroy

    respond_to do |format|
      format.html { redirect_to(admin_gift_certificates_url) }
      format.xml  { head :ok }
    end
  end
end
