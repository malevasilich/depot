APP_CONFIG = YAML.load_file("#{Rails.root}/config/http_proxy.yml")[Rails.env]
