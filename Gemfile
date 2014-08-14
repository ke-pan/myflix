source 'https://rubygems.org'
ruby '2.1.1'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'gravtastic'
gem "bcrypt"
gem 'sidekiq'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog', '~> 1.3.1'
gem 'nokogiri', '~> 1.5.0'
gem 'stripe'
gem 'figaro', git: "https://github.com/laserlemon/figaro"


group :development do
  gem 'sqlite3'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails', '2.99'
  gem 'fabrication'
  gem 'pry'
  gem 'pry-nav'
end

group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'shoulda-matchers', require: false
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'email_spec'
  gem 'capybara-email'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
