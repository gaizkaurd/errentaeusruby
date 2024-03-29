# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Auth
gem 'bcrypt'

# Posgres connector
gem 'pg'

# Compression
gem 'rack-brotli'

# Payment
gem 'stripe'

# Payment-callback
gem 'stripe_event'

# Authorization
gem 'pundit'

# Validation for active storage
gem 'active_storage_validations'

# JWT ENCRYPTION
gem 'jwt'

# DATETIME VALIDATION
gem 'validates_timeliness', '~> 7.0.0.beta1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Job execution
gem 'cloudtasker'

# Cors
gem 'rack-cors'

# Pubsub
gem 'value_semantics'

# Id
gem 'prettyid', require: 'pretty_id'

# Pagy
gem 'pagy'

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :production do
  # Restore client original IP
  gem 'cloudflare-rails'
  # Error tracking
  gem 'honeybadger', '~> 5.0'
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # DOTFILES
  gem 'dotenv-rails'
  # Packages
  gem 'packwerk'
  # Graph dependency visualizacion
  gem 'graphwerk'
  # N+1 queries
  gem 'bullet'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'selenium-webdriver'

  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'webdrivers'

  # Association testing
  gem 'shoulda-matchers', '~> 5.0'

  # Automatic Ruby code style checking tool. (https://github.com/rubocop/rubocop)
  gem 'rubocop', require: false

  # Automatic performance checking tool for Ruby code. (https://github.com/rubocop/rubocop-performance)
  gem 'rubocop-performance', require: false

  # Automatic Rails code style checking tool. (https://github.com/rubocop/rubocop-rails)
  gem 'rubocop-rails', require: false

  # Code style checking for RSpec files (https://github.com/rubocop/rubocop-rspec)
  gem 'rubocop-rspec', require: false

  # RSpec for Rails (https://github.com/rspec/rspec-rails)
  gem 'rspec-rails'

  # Test coverage
  gem 'simplecov', require: false

  # Factorybot
  gem 'factory_bot'

  # Faker
  gem 'faker', '~> 3.1'
end

# Authentification
gem 'rodauth-rails', '~> 1.7'

# Two factor authentication (TOTP)
gem 'rotp', '~> 6.2'

# QR Code
gem 'rqrcode', '~> 2.1'

# Webauthn
gem 'webauthn', '~> 2.5'

# Serialization
gem 'jsonapi-serializer'

# Validation for JSONB fields
gem 'activerecord_json_validator', '~> 2.1'

# Locations
gem 'geocoder', '~> 1.8'

# Storage
gem 'google-cloud-storage', '~> 1.44'

# Tracking
gem 'ahoy_matey'

# API DOC
gem 'rswag'

# Roles
gem 'rolify'

# Search
gem 'ransack'

# Tags
gem 'acts-as-taggable-on', '~> 9.0'

# Authentication with omniauth
gem 'rodauth-omniauth', '~> 0.3.3'

# Authentication with google
gem 'omniauth-google-oauth2', '~> 1.1'

# Authentication
gem 'omniauth', '~> 2.1'

# Google places
gem 'google_places'

# ID3
gem 'decisiontree'

# Math parser
gem 'keisan'

# Dot visualization for decisiontree
gem 'graphr', '~> 0.2.1'
