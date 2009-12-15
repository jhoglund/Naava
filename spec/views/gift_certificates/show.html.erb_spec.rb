require 'spec_helper'

describe "/gift_certificates/show.html.erb" do
  include GiftCertificatesHelper
  before(:each) do
    assigns[:gift_certificate] = @gift_certificate = stub_model(GiftCertificate,
      :name => "value for name",
      :description => "value for description",
      :value => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/1/)
  end
end
