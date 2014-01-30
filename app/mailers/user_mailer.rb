class UserMailer < ActionMailer::Base
  default from: "potest-solum-unum@hilander.io"
  layout "email"

  def new_bounties(user, bounties)
	@bounties = bounties
	@clan = bounties.first.clan
	@stylesheet = 'bounties.css'
	mail to: user.email, subject: "New bounties offered!"  	
  end

  def leaderboard(user, clan)
  	@clan = clan
  	@users = Queries::RunningLeaderboard.new(users_relation: User.leaderboarder, clan: clan).query.decorate
  	@recipient = user

  	mail to: user.email, subject: "Current Leaderboard!"
  end
end
