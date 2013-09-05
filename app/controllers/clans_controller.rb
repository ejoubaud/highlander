class ClansController < ApplicationController
  authorize_resource only: [:edit, :update]

  before_filter :load_decorated_clan, only: [ :show, :update ]

  def show
  end

  def edit
  end

  def update
    if can? :manage, current_clan
      if params[:kin]
        params[:kin].each do |kin_id, attributes|
          @clan.kinships.find(kin_id).update_attributes(attributes)
        end
      end


      if params[:integrations]
        params[:integrations].each do |name, config|
          @clan.set_integration_config(name, config)
        end

        @clan.save!
      end
    end

    redirect_to clan_path
  end

  private

  def load_decorated_clan
    @clan = current_clan.decorate
  end

end
