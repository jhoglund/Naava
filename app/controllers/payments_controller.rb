class PaymentsController < ApplicationController
  def show
    @payment = Payment.find_by_token(params[:id])
    table_name =  @payment.item.class == Coupon ?
                  @payment.item.coupon_type.class.name.tableize :
                  @payment.item.class.name.tableize

    respond_to do |format|
      format.html { render :template => File.join(RAILS_ROOT,'app','views', table_name,"reciept.html.erb") }
      format.xml  { render :xml => @payment }
    end
  end
  
  def update
    @payment = Payment.find_by_token(params[:id])
    @coupon = Coupon.find_by_token(params[:coupon_id])
    if @coupon
      flash[:notice] = "Betalning med värdekupong med referensnumer #{params[:coupon_id]} var lyckad"
      @payment.update_attributes(:reciept => @coupon, :value => @coupon.coupon_type.value)
    else
      flash[:error] = "Vi kunde inte hitta någonvärdekopung med referensnumer #{params[:coupon_id]}"
    end
    redirect_to polymorphic_path(@payment.item, :coupon_id => params[:coupon_id])
  end
end
