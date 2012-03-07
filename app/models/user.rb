require 'net/ldap'
# Contains user login information
# Defines authlogic login functionality
#
class User < ActiveRecord::Base
  has_many :teachings
  has_many :offerings, through: :teachings
  has_many :courses, through: :offerings do
    def frequent(term, limit = 5)
      self.
        available_during(term).
        limit(limit).
        joins(offerings: [:instructors]).
        where(teachings: {user_id: proxy_association.owner.id}).
        select("courses.*").
        group("courses.id").
        select("count(*) as taught_count").
        order("taught_count DESC")
    end
  end

  validates :login, format: { with: /\w+/ }

  acts_as_authentic do |c|
    c.merge_validates_length_of_password_field_options({allow_nil: true})
  end

  ROLES = [:reviewer, :instructor, :staff, :admin]

  def roles=(roles)
    roles = [roles] if roles.is_a? String
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

  def self.facets
    User.all.map {
      |user| {
        :label => user.name,
        :value => "#{user.id}_#{user.to_s.gsub(/\s/, '_')}"
      }
    }
  end

  def to_s
    name
  end

  def teaches?(offering)
    offering.taught_by? self
  end

  scope :with_role, lambda { |role|
    { :conditions => "roles_mask & #{2**ROLES.index(role.to_sym)} > 0"}
  }

  scope :with_offerings_during, lambda { |term|
    includes(:offerings).
    where("offerings.term_id == ?", term.id)
  }

  scope :with_offerings_during_or_before, lambda { |term|
    includes(:offerings).
    where("offerings.term_id <= ?", term.id)
  }

  scope :with_uncomplete_offerings_during_or_before, lambda { |term|
    with_offerings_during_or_before(term).
    where("offerings.stages_left > 0")
  }

  scope :with_complete_offerings_during, lambda { |term|
    with_offerings_during(term).
    where("offerings.stages_left = 0")
  }

  scope :instructors, with_role(:instructor)
end
