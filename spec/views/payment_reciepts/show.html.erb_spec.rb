require 'spec_helper'

describe "/payment_reciepts/show.html.erb" do
  include PaymentRecieptsHelper
  before(:each) do
    assigns[:payment_reciept] = @payment_reciept = stub_model(PaymentReciept,
      :name => "value for name",
      :email => "value for email",
      :note => "value for note",
      :meta => "value for meta",
      :item_id => 1,
      :item_type => "value for item_type"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ email/)
    response.should have_text(/value\ for\ note/)
    response.should have_text(/value\ for\ meta/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ item_type/)
  end
end
