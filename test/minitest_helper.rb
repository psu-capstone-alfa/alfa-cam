require 'simplecov'
require 'minitest/autorun'
require 'minitest/rails'
require 'miniskirt'
require 'factories'
require 'authlogic'
require 'authlogic/test_case'

# Don't fail if `turn` is not available
begin
  require 'turn'
  Turn.config do |config|
    config.natural = true
  end
rescue LoadError
end


SimpleCov.command_name 'MiniTest'

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)


class MiniTest::Rails::Spec
  # Uncomment if you want to support fixtures for all specs
  # or
  # place within spec class you want to support fixtures for
  # include MiniTest::Rails::Fixtures

  # Add methods to be used by all specs here
end

class MiniTest::Rails::Model
  # Add methods to be used by model specs here
end

class MiniTest::Rails::Controller
  include Authlogic::TestCase

  # Add methods to be used by controller specs here
  def must_render_nothing_here
    assert_select '.fail', "Nothing here"
  end

  def self.with_admin_session
    before do
      activate_authlogic
      UserSession.create(Factory :admin)
    end
  end
end

class MiniTest::Rails::Helper
  # Add methods to be used by helper specs here
end

class MiniTest::Rails::Mailer
  # Add methods to be used by mailer specs here
end

class MiniTest::Rails::Integration
  # Add methods to be used by integration specs here
end
