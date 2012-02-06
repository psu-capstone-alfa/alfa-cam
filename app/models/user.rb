# Contains user login information
# Defines authlogic login functionality
#
class User < ActiveRecord::Base
  has_many :teachings
  has_many :offerings, through: :teachings

  acts_as_authentic do |config|
    config.crypted_password_field = nil
    config.validate_password_field(false)
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

  def valid_password?(*args)
    true
  end

  def to_s
    name
  end
end
