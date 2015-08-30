source 'https://rubygems.org'


ruby '2.2.2'

gem 'rails', '4.2.3'
gem 'rails-api'
gem 'pg'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'shoulda-matchers', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
end

gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'bcrypt', '~> 3.1.7' # To use ActiveModel has_secure_password
gem 'has_secure_token'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
