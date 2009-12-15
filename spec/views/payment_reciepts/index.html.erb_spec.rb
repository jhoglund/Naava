require 'spec_helper'

describe "/payment_reciepts/index.html.erb" do
  include PaymentRecieptsHelper

  before(:each) do
    assigns[:payment_reciepts] = [
      stub_model(PaymentReciept,
        :name => "value for name",
        :email => "value for email",
        :note => "value for note",
        :meta => "value for meta",
        :item_id => 1,
        :item_type => "value for item_type"
      ),
      stub_model(PaymentReciept,
        :name => "value for name",
        :email => "value for email",
        :note => "value for note",
        :meta => "value for meta",
        :item_id => 1,
        :item_type => "value for item_type"
      )
    ]
  end

  it "renders a list of payment_reciepts" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for email".to_s, 2)
    response.should have_tag("tr>td", "value for note".to_s, 2)
    response.should have_tag("tr>td", "value for meta".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for item_type".to_s, 2)
  end
end
