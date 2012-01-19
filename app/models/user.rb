#
class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.crypted_password_field = nil
    config.validate_password_field(false)
  end

  def valid_password?(*args)
    true
  end
end
