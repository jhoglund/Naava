require 'spec_helper'

describe "/gift_certificates/new.html.erb" do
  include GiftCertificatesHelper

  before(:each) do
    assigns[:gift_certificate] = stub_model(GiftCertificate,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :value => 1
    )
  end

  it "renders new gift_certificate form" do
    render

    response.should have_tag("form[action=?][method=post]", gift_certificates_path) do
      with_tag("input#gift_certificate_name[name=?]", "gift_certificate[name]")
      with_tag("textarea#gift_certificate_description[name=?]", "gift_certificate[description]")
      with_tag("input#gift_certificate_value[name=?]", "gift_certificate[value]")
    end
  end
end
