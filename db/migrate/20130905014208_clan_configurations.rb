class ClanConfigurations < ActiveRecord::Migration
  def change
    change_table :clans do |t|
      t.text :configuration_settings
    end
  end
end
