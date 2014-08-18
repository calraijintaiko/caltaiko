source 'https://rubygems.org'
ruby "2.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use rubygems 2.3.0
gem 'rubygems-update', '~> 2.3.0'
# Use Postgres as database for Active Record since required by Heroku
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Fix javascript not loading because of turbolinks
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use Device for authentification
gem 'devise'

# Use Paperclip to attach images
gem 'paperclip', '~> 4.1'
# Paperclip requires cocaine
gem 'cocaine', '~> 0.5.4'
# Enable AWS support
gem 'aws-sdk'

# Allows more features in Heroku
gem 'rails_12factor', group: :production

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Add New Relic for data analysis
gem 'newrelic_rpm'

# Enables prettier urls, ie caltaiko.com/members/tom-hata vs caltaiko.com/members/1
gem 'friendly_id', '~> 5.0.0'

# Allows for easier meta tag setting
gem 'metamagic'

# Allows for use of Haml rather than standard erb
gem 'haml'
gem 'haml-rails', group: :development
gem 'redcarpet', '~> 3.0'

# Prettier forms
gem 'simple_form'

# Better nested forms
gem 'cocoon'

# Testing-suite gems
group :development, :test do 
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
  gem 'rb-fsevent'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
end
