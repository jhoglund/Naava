class Admin::CouponsController < Admin::AdminController
  # GET /coupons
  # GET /coupons.xml
  def index
    @coupons = Coupon.all.sort_by{|c| c.valid? ? 0:1 }.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coupons }
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
    @coupon = Coupon.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coupon }
    end
  end

  def edit
    @coupon = Coupon.find_by_token(params[:id])
  end

  def create
    @coupon = Coupon.new(params[:coupon])
    @coupon.payment = Payment.new(:name => @coupon.to_name)
    @coupon.type = @coupon.coupon_type.class.name.gsub(/Type$/,'')

    respond_to do |format|
      if @coupon.save
        flash[:notice] = 'Coupon was successfully created.'
        format.html { redirect_to(admin_coupon_url(@coupon)) }
        format.xml  { render :xml => @coupon, :status => :created, :location => @coupon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @coupon = Coupon.find_by_token(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[params[:class_type_name]])
        flash[:notice] = 'Coupon was successfully updated.'
        format.html { redirect_to(admin_coupon_url(@coupon)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @coupon = Coupon.find_by_token(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to(admin_coupons_url) }
      format.xml  { head :ok }
    end
  end
  
end
