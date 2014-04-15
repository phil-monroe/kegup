class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.is_admin?
      can :manage, :all
    else
      can :read, Org
      can :read, User

      can :update, User, :id => user.id
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
