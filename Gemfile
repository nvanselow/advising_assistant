source 'https://rubygems.org/'

ruby '2.2.3'

gem 'rails', '4.2.6'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'materialize-sass'
gem 'devise'
gem 'pg_search'
gem 'carrierwave'
gem 'validates_timeliness', '~> 4.0'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'signet'
gem 'google-api-client', '0.9'
gem 'omniauth-microsoft-office365'
gem 'ruby_outlook'
gem 'faker'
gem 'mini_magick'

group :development, :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-rails'
  gem 'shoulda'
  gem 'valid_attribute'
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
end

group :test do
  gem 'launchy', require: false
  gem 'coveralls', require: false
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'orderly'
  gem 'poltergeist'
  gem 'selenium-webdriver'
end

group :development do
  gem 'mailcatcher'
end

group :development, :production do
  gem 'fog'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
end
