require 'simplecov'
require 'minitest/autorun'
require 'minitest/rails'
require 'miniskirt'
require 'factories'
require 'authlogic'
require 'authlogic/test_case'


SimpleCov.command_name 'MiniTest'

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)


module AuthlogicTestHelpers
  def with_admin_session
    before do
      activate_authlogic
      UserSession.create!(Factory :admin)
    end
  end

  def with_user(user)
    before do
      activate_authlogic
      UserSession.create!(user)
    end
  end
end

# Make the basic class MiniTest::Rails::Spec instead of MiniTest::Spec
MiniTest::Spec::TYPES.last[1] = MiniTest::Rails::Spec

class MiniTest::Rails::Spec
  include Authlogic::TestCase
  extend AuthlogicTestHelpers

  def run(*args, &blk)
    run_output = nil
    ActiveRecord::Base.transaction do
      run_output = super
      raise ActiveRecord::Rollback
    end
    run_output
  end
end

class MiniTest::Rails::Model
end

class MiniTest::Rails::Controller
  def must_render_nothing_here
    assert_select '.fail', "Nothing here"
  end
end

class MiniTest::Rails::Helper
end

class MiniTest::Rails::Mailer
end

class MiniTest::Rails::Integration
end
