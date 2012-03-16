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
      can :update, Offering do |offering|
        offering.taught_by? user
      end
      can :profile, User
      can :update, User, :id => user.id
      can :read, :all
    end
    if user.is? :staff
      can :manage, Course
      can :manage, AcademicTerm
      can :manage, Outcome
      can :manage, OutcomeGroup
      can :manage, Offering
      can :manage, ContentGroupName
      can :manage, :all
      can :read, :all
    end
    if user.is? :admin
      can :manage, :all
    end
  end

end
