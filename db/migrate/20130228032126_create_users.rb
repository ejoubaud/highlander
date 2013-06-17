class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :slug
      t.string  :email
      t.string  :emails, array: true, default: '{}'
      t.string  :bio, limit: 128
      t.string  :avatar_url
      t.string  :role, default: 'guest'
      t.boolean :enabled, default: true
      t.boolean :earns_points, default: true
      t.boolean :leaderboarder, default: true

      t.timestamps
    end

    add_index :users, :slug, unique: true
  end
end
