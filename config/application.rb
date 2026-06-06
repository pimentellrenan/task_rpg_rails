require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module TaskRpgRails
  class Application < Rails::Application
    config.load_defaults 8.0
    config.paths.add "config/database", with: "config/database.yml"
    config.time_zone = "America/Sao_Paulo"
    config.active_record.default_timezone = :local
    config.action_controller.asset_host = ENV["ASSET_HOST"] if ENV["ASSET_HOST"].present?
  end
end
