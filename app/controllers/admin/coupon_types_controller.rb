class Admin::CouponTypesController < Admin::AdminController
  def index
    @coupon_types = CouponType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coupon_types }
    end
  end

  def show
    @coupon_type = CouponType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coupon_type }
    end
  end

  def new
    @coupon_type = CouponType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coupon_type }
    end
  end

  def edit
    @coupon_type = CouponType.find(params[:id])
  end

  def create
    @coupon_type = CouponType.new(params[:coupon_type])

    respond_to do |format|
      if @coupon_type.save
        flash[:notice] = 'CouponType was successfully created.'
        format.html { redirect_to(admin_coupon_type_path(@coupon_type)) }
        format.xml  { render :xml => @coupon_type, :status => :created, :location => @coupon_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coupon_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @coupon_type = CouponType.find(params[:id])

    respond_to do |format|
      if @coupon_type.update_attributes(params[:coupon_type])
        flash[:notice] = 'CouponType was successfully updated.'
        format.html { redirect_to(admin_coupon_type_path(@coupon_type)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coupon_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @coupon_type = CouponType.find(params[:id])
    @coupon_type.destroy

    respond_to do |format|
      format.html { redirect_to(admin_coupon_types_url) }
      format.xml  { head :ok }
    end
  end
end
