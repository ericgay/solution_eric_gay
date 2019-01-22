config = YAML.load_file("config/redis.yml")[Rails.env].symbolize_keys
ShaManager.connection = config
