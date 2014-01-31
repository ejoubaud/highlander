class UserMailer < ActionMailer::Base
  default from: "Hilander <potest-solum-unum@hilander.io>"
  layout "email"

  def new_bounties(user, bounties)
    @bounties = bounties
    @user = user
    @clan = bounties.first.clan

    @stylesheet = 'bounties.css'
    mail to: user.primary_email, subject: "[hilander] New bounties offered in #{@clan.name}!"   
  end

  def leaderboard(user, clan)
    @clan = clan
    @user = user
    @users = Queries::RunningLeaderboard.new(users_relation: User.leaderboarder, clan: clan).query.decorate
    @recipient = user

    mail to: user.primary_email, subject: "[hilander] Current Leaderboard for #{@clan.name}!"
  end
end
