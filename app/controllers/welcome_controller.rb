class WelcomeController < ApplicationController

  def index
    @users = Queries::RunningLeaderboard.new(users_relation: User.leaderboarder, clan: current_clan).query.decorate
  end

end
