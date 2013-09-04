class UsersController < ApplicationController
  authorize_resource only: [:edit, :update]

  before_filter :load_user,           only: [ :edit, :update ]
  before_filter :load_decorated_user, only: [ :show ]

  def index
    @users = User.all
  end

  def show
    @stats = Rails.cache.fetch("user-stats-#{user.id}", expires_in: 5.minutes) do
      Queries::Stats.new(user: user.user, achievements: false).query
    end
  end

  def edit
    @user = UserAccountDecorator.new(@user)
  end

  def update
    @user = UserAccountDecorator.new(@user)

    @user.attributes = user_params
    @user.save!
    redirect_to user_path(@user.source)
  end

  def link_to_github
    login = request.env['omniauth.auth']['info']['nickname']
    UserAccountDecorator.new(current_user).set_service(:github, login)
    redirect_to(user_path(current_user), { notice: "Github added to your account: #{login}" })
  end

  private

    def load_decorated_user
      @user = user.decorate
    end

    def load_user
      @user = user
    end

    def user
      @user ||= User.find(params[:id])
    end

    def user_params
      params[:user].permit(:name, :email, :bio, :github_account, :twitter_account, :instagram_account, :pager_duty_account)
    end

end
