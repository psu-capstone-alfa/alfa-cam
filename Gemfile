source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false,
    :git => "https://github.com/scoz/turn.git",
    :branch => "ignore-empty-cases"
end

# Testing setup
group :test, :development do
  gem 'minitest-rails', # FIXME: This shouldn't depend on Ryan's personal fork
    :git => "https://github.com/scoz/minitest-rails.git",
    :branch => "gemspec"
    #:branch => "rake-merge-tasks"
  gem 'simplecov', :require => false
  gem 'cane'
  gem 'miniskirt'
end

# User session management
gem 'authlogic', # FIXME: This shouldn't depend on Ryan's personal fork
  :git => "https://github.com/scoz/authlogic.git",
  :branch => "fix-rails-adapter"

# Twitter Bootstrap integration
# FIXME: This shouldn't depend on Eric's personal fork ;)
gem 'twitter-bootstrap-rails',
    :git => 'http://github.com/drd/twitter-bootstrap-rails.git'
