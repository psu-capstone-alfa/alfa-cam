# Defines permissions of different user roles
#
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is? :reviewer
      can :read, :all
    end
    if user.is? :instructor
      can :manage, Offering do |offering|
        offering.taught_by user
      end
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

end
