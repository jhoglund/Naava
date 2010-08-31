class Notification < ActionMailer::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper
  default_url_options[:host] = AppConfig[:host]

  def mail(subject, address, object, template)
    recipients((RAILS_ENV == "development") ? "hoglundj@gmail.com" : address)
    from("#{AppConfig[:support_mail_title]} <#{AppConfig[:support_mail]}>")
    headers("return-path" => "#{AppConfig[:support_mail]}")
    subject(subject)
    body(render_message(template, :object => object))
  end
  
  def self.get_template instance, file_name
    File.join(RAILS_ROOT,'app','views',instance.class.name.tableize,"#{file_name}.text.plain.erb")
  end
  
end
  
