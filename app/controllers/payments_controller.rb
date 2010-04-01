class PaymentsController < ApplicationController
  def show
    @payment = Payment.find_by_token(params[:id])
    table_name =  case @payment.item.class.name
                  when 'Coupon'
                    @payment.item.coupon_type.class.name.tableize
                  when 'Booking'
                    @payment.item.booker.class.name.tableize
                  else
                    @payment.item.class.name.tableize
                  end

    respond_to do |format|
      format.html { render :template => File.join(RAILS_ROOT,'app','views', table_name,"reciept.html.erb") }
      format.xml  { render :xml => @payment }
    end
  end
  
  def update
    @payment = Payment.find_by_token(params[:id])
    @coupon = Coupon.find_by_token(params[:coupon_id])
    if @coupon
      if @coupon.valid_for?(@payment.item.booker)
        begin
          if @coupon.valid?
            #@payment.update_attributes(:reciept => @coupon, :value => 1)
            @coupon.use!(@payment, @payment.item.booker.price)
            flash[:notice] = "Betalning med värdekupong med referensnumer #{params[:coupon_id]} var lyckad"
          else
            flash[:error] = "Värdekupongen med referensnumer #{params[:coupon_id]} kan inte användas för denna betalningen. Kupongen är redan fullt utnyttjad."
          end
        rescue Payment::UnsufficentFunds
          flash[:error] = "Värdekupongen med referensnumer #{params[:coupon_id]} är inte betald och kan därför inte utnyttjas."
        end
      else
        flash[:error] = "Värdekupongen med referensnumer #{params[:coupon_id]} kan inte användas för denna betalningen då kupongen är av typen \"#{@coupon.coupon_type.name}\"."
      end
    else
      flash[:error] = "Vi kunde inte hitta någon värdekopung med referensnumer #{params[:coupon_id]}"
    end
    redirect_to polymorphic_path(@payment.item, :coupon_id => params[:coupon_id])
  end
end
