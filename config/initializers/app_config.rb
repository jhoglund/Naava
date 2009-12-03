def load_app_config
  app_conf = YAML::load(ERB.new(IO.read(File.join(RAILS_ROOT, 'config', 'app.yml'))).result)[RAILS_ENV]
  app_conf.symbolize_keys
end
AppConfig = load_app_config