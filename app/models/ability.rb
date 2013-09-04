class Ability
  include CanCan::Ability

  def initialize(user, clan)
    user ||= User.new
    clan ||= Clan.new
    kinship = clan.kinship_for_user(user)

    case kinship.role
      when 'admin'
        can :manage, :all

      when 'user'
        can [ :read ], Bounty
        can [ :manage ], Bounty, :created_by_id => user.id
        can [ :edit, :update ], User, :id => user.id

      when 'guest'

    end
  end
end
