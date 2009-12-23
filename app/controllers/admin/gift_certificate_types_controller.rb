class Admin::GiftCertificateTypesController < Admin::AdminController
  def index
    @gift_certificate_type = GiftCertificateType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gift_certificate_type }
    end
  end

  def show
    @gift_certificate_type = GiftCertificateType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gift_certificate_type }
    end
  end

  def new
    @gift_certificate_type = GiftCertificateType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gift_certificate_type }
    end
  end

  def edit
    @gift_certificate_type = GiftCertificateType.find(params[:id])
  end

  def create
    @gift_certificate_type = GiftCertificateType.new(params[:gift_certificate_type])

    respond_to do |format|
      if @gift_certificate_type.save
        flash[:notice] = 'GiftCertificateType was successfully created.'
        format.html { redirect_to(admin_gift_certificate_type_path(@gift_certificate_type)) }
        format.xml  { render :xml => @gift_certificate_type, :status => :created, :location => @gift_certificate_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gift_certificate_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @gift_certificate_type = GiftCertificateType.find(params[:id])

    respond_to do |format|
      if @gift_certificate_type.update_attributes(params[:gift_certificate_type])
        flash[:notice] = 'GiftCertificateType was successfully updated.'
        format.html { redirect_to(admin_gift_certificate_type_path(@gift_certificate_type)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gift_certificate_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @gift_certificate_type = GiftCertificateType.find(params[:id])
    @gift_certificate_type.destroy

    respond_to do |format|
      format.html { redirect_to(admin_gift_certificate_types_url) }
      format.xml  { head :ok }
    end
  end
end
