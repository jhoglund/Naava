require 'spec_helper'

describe "/gift_certificates/index.html.erb" do
  include GiftCertificatesHelper

  before(:each) do
    assigns[:gift_certificates] = [
      stub_model(GiftCertificate,
        :name => "value for name",
        :description => "value for description",
        :value => 1
      ),
      stub_model(GiftCertificate,
        :name => "value for name",
        :description => "value for description",
        :value => 1
      )
    ]
  end

  it "renders a list of gift_certificates" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
