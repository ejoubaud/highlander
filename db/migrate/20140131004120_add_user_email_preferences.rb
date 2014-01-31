class AddUserEmailPreferences < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :send_leaderboard, default: true, null: false
      t.boolean :send_bounties, default: true, null: false
    end
  end
end
