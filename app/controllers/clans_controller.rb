class ClansController < ApplicationController
  authorize_resource only: [:edit, :update]

  before_filter :load_decorated_clan, only: [ :show ]

  def show
  end

  def edit
  end

  def update
    params[:kin].each do |kin_id, attributes|
      current_clan.kinships.find(kin_id).update_attributes(attributes)
    end

    redirect_to clan_path(@clan)
  end

  private

  def load_decorated_clan
    @clan = current_clan.decorate
  end

end
