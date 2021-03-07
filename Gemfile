# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 5.2.4'
# Use mysql for db
gem 'mysql2', '~> 0.5.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use serialization for basic structuring of CRUD responses
gem 'active_model_serializers', '~> 0.10.7'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
# Ease pagination logic
gem 'kaminari', '~> 1.2.1'

group :development, :test do
  gem 'pry-byebug', '~> 3'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'faker', '~> 1.8.4'
  gem 'rspec-rails', '~> 3.7.1'
  gem 'shoulda-matchers'
end
