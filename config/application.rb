require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module TaskRpgRails
  class Application < Rails::Application
    config.load_defaults 8.0
    config.time_zone = "America/Sao_Paulo"
    config.active_record.default_timezone = :local
  end
end
