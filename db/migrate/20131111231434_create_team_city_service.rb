class CreateTeamCityService < ActiveRecord::Migration
  def change
    create_table :team_city_services do |t|
      t.string :username, null: false
      t.timestamps
    end
  end
end