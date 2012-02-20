# A login-session of a user
# Not currently persisted to the database
#
class UserSession < Authlogic::Session::Base
  attr_accessor :login_type ## :local or :ldap

  def initialize(*args)
    super
    options = args.extract_options!
    @login_type = options[:login_type] || :ldap
  end

  def verify_password_method
    case @login_type
      when :local
        'valid_password?'
      when :skip # TODO:rs remove login avoidance
        'skip_password_check'
      #when :ldap
      else
        'valid_ldap_password?'
    end
  end
end
