source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'

group :production do
	gem 'pg'
	gem 'rails_12factor'
end

group :development do
	gem 'sqlite3'
	gem 'pry-rails'
end

group :development, :test do
	gem 'rspec-rails', '~> 3.0'
	gem 'factory_girl_rails', '~> 4.0'
	gem 'capybara'
	gem 'guard-rspec'
	gem 'spring-commands-rspec'
	gem 'vcr'
	gem 'shoulda'
	gem 'faker'
end

group :test do
	gem 'webmock'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise'
# Twitter's Bootstrap, converted to Sass and ready to drop into Rails or Compass
gem 'bootstrap-sass', '~> 3.3.5.1'
# Figaro will store Sendgrid and Devise credentials as environment variables.
gem 'figaro', '1.0'