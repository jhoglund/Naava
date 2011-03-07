conf = YAML::load(ERB.new(IO.read(File.join(RAILS_ROOT, 'config', 'captcha.yml'))).result)
conf.symbolize_keys

CAPTCHA_SALT    = conf[:captcha_salt]