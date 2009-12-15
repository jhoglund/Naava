class PaymentsController < ApplicationController
  def show
    @payment = Payment.find_by_token(params[:id])

    respond_to do |format|
      format.html { render :template => File.join(RAILS_ROOT,'app','views',@payment.item.class.name.tableize,"reciept.html.erb") }
      format.xml  { render :xml => @payment }
    end
  end
end
