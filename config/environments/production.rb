Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.public_file_server.headers = { "cache-control" => "public, max-age=31536000" }
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.active_storage.service = :local
  config.force_ssl = true
  config.log_level = :info
end
