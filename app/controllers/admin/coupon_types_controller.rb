class Admin::CouponTypesController < Admin::AdminController
  def index
    @coupon_type = CouponType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coupon_type }
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
    @coupon_type = typecast_class.new(params[class_type_name])

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
    klass = typecast_class
    respond_to do |format|
      @coupon_type.valid_for = []
      if @coupon_type.update_attributes(params[class_type_name])
        if !@coupon_type.is_a?(klass)
          @coupon_type = @coupon_type.becomes(klass)
          @coupon_type.type = klass.name
          @coupon_type.save
        end
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
  
  private
  
  def class_type_name
    params[:class_type_name]
  end
  
  def typecast_class
    klass_type = params[class_type_name].delete(:type)
    klass_type.nil? ? CouponType : klass_type.constantize
  end
end
