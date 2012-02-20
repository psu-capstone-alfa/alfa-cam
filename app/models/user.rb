require 'net/ldap'
# Contains user login information
# Defines authlogic login functionality
#
class User < ActiveRecord::Base
  has_many :teachings
  has_many :offerings, through: :teachings

  validates :login, format: { with: /\w+/ }

  acts_as_authentic do |config|
  end

  ROLES = %w[instructor staff admin reviewer].map! &:to_sym

  def roles=(roles)
    roles.map!(&:to_sym)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_sym)
  end

  def valid_ldap_password?(password)
    ldap = Net::LDAP.new
    ldap.host = 'ldap.cat.pdx.edu'
    ldap.port = 389
    ldap.encryption(:start_tls)
    ldap.auth "uid=#{login},ou=People,dc=catnip", password
    ldap.bind
  end

  # Called when password checking is being skipped
  # TODO:rs don't keep this around in production
  def skip_password_check(*)
    puts "Skipped password check"
    true
  end

  def to_s
    name
  end

  scope :with_role, lambda { |role|
    { :conditions => "roles_mask & #{2**ROLES.index(role.to_sym)} > 0"}
  }
end
