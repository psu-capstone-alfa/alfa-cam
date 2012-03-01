source 'http://rubygems.org'

RAILS_VERSION = '~> 3.2.0'

gem 'rails', RAILS_VERSION

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   RAILS_VERSION
  gem 'coffee-rails', RAILS_VERSION
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# Testing setup
group :test, :development do
  gem 'minitest'
  gem 'minitest-rails', # FIXME: This shouldn't depend on Ryan's personal fork
    :git => "https://github.com/scoz/minitest-rails.git",
    :branch => "gemspec"
  gem 'simplecov', :require => false
  gem 'cane'
  gem 'miniskirt'
end

# User session management
gem 'authlogic', # FIXME: This shouldn't depend on Ryan's personal fork
  :git => "https://github.com/scoz/authlogic.git",
  :branch => "fix-rails-adapter"
gem 'cancan'

gem 'forgery'

# Twitter Bootstrap integration
gem 'twitter-bootstrap-rails' #,
  #:git => "https://github.com/seyhunak/twitter-bootstrap-rails.git"

gem 'acts_as_list' #, :git => 'git://github.com/swanandp/acts_as_list'

group :ldap do
  gem 'net-ldap'
end

gem 'seedbank'
gem 'activerecord-import'
