class CouponController < ApplicationController
  include PaymentControllerModule

  def new
    @coupon = Coupon.new()
     
    respond_to do |format|
      format.html
      format.xml  { render :xml => @coupon }
    end
  end

  def create
    @coupon = Coupon.new(params[:coupon])

    respond_to do |format|
      if @coupon.save
        flash[:notice] = 'Coupon was successfully created.'
        format.html { redirect_to(payment_path(@coupon.payment)) }
        format.xml  { render :xml => @coupon, :status => :created, :location => @coupon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end
end
