source 'https://rubygems.org'
ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'
# Use rubygems 2.6.0
gem 'rubygems-update', '~> 2.6.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
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

# Use Devise for authentification
gem 'devise'

# Use Paperclip to attach images
gem 'paperclip', '~> 4.1'
# Enable AWS support
gem 'aws-sdk-v1'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Enables prettier urls, ie /members/tom-hata vs /members/1
gem 'friendly_id', '~> 5.1.0'

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
gem 'foundation-rails', '~> 5.5.0'

# Parse and validate phone numbers
gem 'phonelib'

# Use the DataTables jQuey plug-in for sortable, beautiful tables
gem 'jquery-datatables-rails', '~> 3.4.0'

group :production do
  # Use Postgres as database for Active Record since required by Heroku
  gem 'pg'
  # Use unicorn as the app server
  gem 'unicorn'
  # Allows more features in Heroku
  gem 'rails_12factor'
end

# Testing-suite gems
group :development, :test do
  gem 'sqlite3'
  gem 'simplecov'
  gem 'rb-fsevent'
end

group :test do
  gem 'faker'
  gem 'timecop'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'codeclimate-test-reporter', require: nil
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end

group :development do
  gem 'spring'
  gem 'guard-rspec'
  gem 'guard-cucumber', '~>1.6.0'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
  gem 'annotate', '~> 2.6.5'
  gem 'scss-lint', '~>0.30'
  gem 'haml-lint', '~>0.10'
  gem 'reek'
  gem 'overcommit'
  gem 'ruby-lint'
  gem 'travis'
  gem 'web-console'
  gem 'pry-rails'
  gem 'pry-byebug', '~>3.3.0'
  gem 'quiet_assets'
end
