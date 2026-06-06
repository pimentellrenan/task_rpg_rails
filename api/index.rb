ENV["RAILS_ENV"] ||= "production"
ENV["RAILS_SERVE_STATIC_FILES"] ||= "true"

require "stringio"
require_relative "../config/environment"

Handler = Proc.new do |request, response|
  body = request.body || ""
  rack_env = {
    "REQUEST_METHOD" => request.request_method,
    "SCRIPT_NAME" => "",
    "PATH_INFO" => request.path,
    "QUERY_STRING" => request.query_string.to_s,
    "SERVER_NAME" => request.host,
    "SERVER_PORT" => request.port.to_s,
    "rack.version" => Rack::VERSION,
    "rack.input" => StringIO.new(body),
    "rack.errors" => $stderr,
    "rack.multithread" => false,
    "rack.multiprocess" => false,
    "rack.run_once" => false,
    "rack.url_scheme" => request.ssl? ? "https" : "http"
  }

  request.each do |key, value|
    header = "HTTP_#{key.upcase.tr("-", "_")}"
    rack_env[header] = value
  end

  status, headers, rack_body = Rails.application.call(rack_env)
  response.status = status
  headers.each { |key, value| response[key] = value unless key.downcase == "status" }
  response.body = +""
  rack_body.each { |chunk| response.body << chunk }
ensure
  rack_body&.close if rack_body.respond_to?(:close)
end
