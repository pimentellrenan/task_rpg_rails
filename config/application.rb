require_relative "boot"

require "rails/all"
require "erb"
require "yaml"

Bundler.require(*Rails.groups)

module TaskRpgRails
  class Application < Rails::Application
    config.load_defaults 8.0
    database_config_path = root.join("config/database.yml")
    config.active_record.database_configuration = YAML.safe_load(
      ERB.new(database_config_path.read).result,
      aliases: true
    )
    config.time_zone = "America/Sao_Paulo"
    config.active_record.default_timezone = :local
    config.action_controller.asset_host = ENV["ASSET_HOST"] if ENV["ASSET_HOST"].present?
  end
end
