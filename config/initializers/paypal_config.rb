def load_paypal_config
  paypal_conf = YAML::load(ERB.new(IO.read(File.join(RAILS_ROOT, 'config', 'paypal', 'config.yml'))).result)
  default_paypal_conf = paypal_conf.delete('production')
  (default_paypal_conf[RAILS_ENV]||[]).each do |conf|
    default_paypal_conf[paypal_conf.first] = paypal_conf.last
  end
  default_paypal_conf.symbolize_keys
end
PaypalConfig = load_paypal_config