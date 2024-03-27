source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"

gem "devise", "~> 4.9.2"
gem "devise_token_auth", "~> 1.2.0", git: "https://github.com/lynndylanhurley/devise_token_auth"

gem "rack", "~> 3.0.9"
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors", "~> 2.0.2"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# HTTP Request library
# gem "faraday", "~> 2.9.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 6.1.2"
  gem "shoulda-matchers", "~> 6.0"
  gem "factory_bot_rails", "~> 6.4.3"
  gem "faker", "~> 3.3.0"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring", "~> 4.1.0"
  gem "listen", "~> 3.9.0"
  gem "rubocop", "~> 1.62.1"
end
