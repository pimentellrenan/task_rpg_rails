source "https://rubygems.org"

ruby "~> 3.3.0"

gem "rails", "~> 8.0.0"
gem "pg", "~> 1.5"
gem "puma", ">= 6.0"
gem "bcrypt", "~> 3.1.7"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
