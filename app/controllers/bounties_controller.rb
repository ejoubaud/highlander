class BountiesController < ApplicationController

  before_action :set_bounty, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @claimed_bounties = Bounty.for_clan(current_clan).claimed.decorate
    @unclaimed_bounties = Bounty.for_clan(current_clan).unclaimed.decorate
  end

  def show
  end

  def mails
    # render text: UserMailer.new_bounties(current_user, current_clan.bounties).body.to_s
    render text: UserMailer.leaderboard(current_user, current_clan).body.to_s
  end

  def new
    if Bounty.for_clan(current_clan).has_max_allowed?(current_user)
      redirect_to bounties_path, flash: { error: "You can only have #{Bounty::MAX_ACTIVE_BOUNTIES} unclaimed bounties at any one time" }
    end
    @bounty = Bounty.new
  end

  def edit
    @users = current_clan.users.point_earner.order(:name)
    raise 'Bounty already claimed' if @bounty.claimed?
  end

  def create
    @bounty = Bounty.for_clan(current_clan).new(bounty_params)
    @bounty.created_by_id = current_user.id

    respond_to do |format|
      if @bounty.save
        BountyMailer.new_bounty(current_user, current_clan, @bounty).deliver
        format.html { redirect_to bounties_path, notice: 'Bounty was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|

      if @bounty.update(bounty_params)
        format.html { redirect_to bounties_path, notice: 'Bounty was successfully updated.' }
      else
         @users = User.point_earner.order(:name)
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @bounty.destroy
    respond_to do |format|
      format.html { redirect_to bounties_url, notice: 'Bounty was successfully destroyed.' }
    end
  end

  private

  def set_bounty
    @bounty = Bounty.find(params[:id])
  end

  def bounty_params
    params.require(:bounty).permit(:name, :description, :reward, :claimed_by_id, :needs_claiming_by, :claimed_at)
  end
end
