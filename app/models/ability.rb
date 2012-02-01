class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is? :reviewer
      can :read, :all
    end
    if user.is? :instructor
      can :read, :all
    end
    if user.is? :staff
      can :manage, Course
      can :manage, Term
      can :manage, Outcome
      can :manage, Offering
      can :read, :all
    end
    if user.is? :admin
      can :manage, :all
    end
  end

  def self.ignore_auth
    Ability.new(nil).ignore_authorizations
  end

  def ignore_authorizations
    can :manage, :all
  end
end
