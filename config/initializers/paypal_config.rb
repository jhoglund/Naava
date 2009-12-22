def load_paypal_config
  paypal_conf = YAML::load(ERB.new(IO.read(File.join(RAILS_ROOT, 'config', 'paypal', 'config.yml'))).result)[RAILS_ENV]
  paypal_conf.symbolize_keys
end
PaypalConfig = load_paypal_config
Paypal::Notification.paypal_cert = File::read(PaypalConfig[:paypal_cert])
Paypal::Notification.ipn_url = PaypalConfig[:notification_url]