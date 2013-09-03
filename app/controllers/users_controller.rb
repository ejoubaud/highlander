class UsersController < ApplicationController
  authorize_resource only: [:edit, :update]

  before_filter :load_user,           only: [ :edit, :update ]
  before_filter :load_decorated_user, only: [ :show ]

  before_filter :load_kinship,           only: [ :edit, :update ]
  before_filter :load_decorated_kinship, only: [ :show ]

  def index
    @users = User.all
  end

  def show
    @stats = Rails.cache.fetch("user-stats-#{user.id}-#{current_clan.id}", expires_in: 5.minutes) do
      Queries::Stats.new(kinship: user.user.kinships.for_clan(current_clan).first, achievements: false).query
    end
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    redirect_to user_path(@user)
  end

  private

    def load_decorated_user
      @user = user.decorate
    end

    def load_user
      @user = user
    end

    def load_decorated_kinship
      @kinship = kinship.decorate
    end

    def load_kinship
      @kinship = kinship
    end

    def user
      @user ||= User.find(params[:id])
    end

    def kinship
      @kinship ||= User.find(params[:id]).kinships.for_clan(current_clan).first
    end

    def user_params
      params[:user].permit(:name, :email, :bio)
    end

end
