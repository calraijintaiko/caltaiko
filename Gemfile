source 'https://rubygems.org'
ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'
# Use rubygems 2.3.0
gem 'rubygems-update', '~> 2.3.0'
# Use Postgres as database for Active Record since required by Heroku
# If having trouble installing, probably need to install Postgres.app first
# Also make sure that your PATH environment variable includes the Postgres
# bin, ie make sure your startup script includes something like the following:
# export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin/
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Fix javascript not loading because of turbolinks
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the
# background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use Device for authentification
gem 'devise'

# Use Paperclip to attach images
gem 'paperclip', '~> 4.1'
# Enable AWS support
gem 'aws-sdk'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Enables prettier urls, ie /members/tom-hata vs /members/1
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

# Enables Foundation framework
gem 'modernizr-rails'
gem 'foundation-rails', '~> 5.4.5.0'

group :production do
  # Use unicorn as the app server
  gem 'unicorn'
  # Allows more features in Heroku
  gem 'rails_12factor'
end

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

group :development do
  gem 'scss-lint', '~>0.30'
  gem 'haml-lint', '~>0.10'
  gem 'reek', '~>1.5.0'
  gem 'overcommit'
  gem 'ruby-lint'
  gem 'travis'
  gem 'web-console'
  gem 'pry-rails'
end
