require 'spec_helper'

describe "/payment_reciepts/edit.html.erb" do
  include PaymentRecieptsHelper

  before(:each) do
    assigns[:payment_reciept] = @payment_reciept = stub_model(PaymentReciept,
      :new_record? => false,
      :name => "value for name",
      :email => "value for email",
      :note => "value for note",
      :meta => "value for meta",
      :item_id => 1,
      :item_type => "value for item_type"
    )
  end

  it "renders the edit payment_reciept form" do
    render

    response.should have_tag("form[action=#{payment_reciept_path(@payment_reciept)}][method=post]") do
      with_tag('input#payment_reciept_name[name=?]', "payment_reciept[name]")
      with_tag('input#payment_reciept_email[name=?]', "payment_reciept[email]")
      with_tag('textarea#payment_reciept_note[name=?]', "payment_reciept[note]")
      with_tag('textarea#payment_reciept_meta[name=?]', "payment_reciept[meta]")
      with_tag('input#payment_reciept_item_id[name=?]', "payment_reciept[item_id]")
      with_tag('input#payment_reciept_item_type[name=?]', "payment_reciept[item_type]")
    end
  end
end
