class Admin::UserGiftCertificatesController < Admin::AdminController
  # GET /user_gift_certificates
  # GET /user_gift_certificates.xml
  def index
    @user_gift_certificates = UserGiftCertificate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_gift_certificates }
    end
  end

  # GET /user_gift_certificates/1
  # GET /user_gift_certificates/1.xml
  def show
    @user_gift_certificate = UserGiftCertificate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_gift_certificate }
    end
  end

  # GET /user_gift_certificates/new
  # GET /user_gift_certificates/new.xml
  def new
    @user_gift_certificate = UserGiftCertificate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_gift_certificate }
    end
  end

  # GET /user_gift_certificates/1/edit
  def edit
    @user_gift_certificate = UserGiftCertificate.find(params[:id])
  end

  # POST /user_gift_certificates
  # POST /user_gift_certificates.xml
  def create
    @user_gift_certificate = UserGiftCertificate.new(params[:user_gift_certificate])

    respond_to do |format|
      if @user_gift_certificate.save
        flash[:notice] = 'UserGiftCertificate was successfully created.'
        format.html { redirect_to(@user_gift_certificate) }
        format.xml  { render :xml => @user_gift_certificate, :status => :created, :location => @user_gift_certificate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_gift_certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_gift_certificates/1
  # PUT /user_gift_certificates/1.xml
  def update
    @user_gift_certificate = UserGiftCertificate.find(params[:id])

    respond_to do |format|
      if @user_gift_certificate.update_attributes(params[:user_gift_certificate])
        flash[:notice] = 'UserGiftCertificate was successfully updated.'
        format.html { redirect_to(@user_gift_certificate) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_gift_certificate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_gift_certificates/1
  # DELETE /user_gift_certificates/1.xml
  def destroy
    @user_gift_certificate = UserGiftCertificate.find(params[:id])
    @user_gift_certificate.destroy

    respond_to do |format|
      format.html { redirect_to(user_gift_certificates_url) }
      format.xml  { head :ok }
    end
  end
end
