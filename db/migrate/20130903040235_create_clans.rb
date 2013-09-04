class CreateClans < ActiveRecord::Migration
  def change
    create_table :clans do |t|
      t.string :name
      t.string :slug

      t.timestamps

      t.index :slug
    end

    create_table :kinships do |t|
      t.references :clan
      t.references :user
      t.string :role, default: "guest"

      t.timestamps     
    end

    change_table :achievements do |t|
      t.references :kinship
      t.index :kinship_id
    end

    change_table :events do |t|
      t.references :kinship
      t.index :kinship_id
    end

    change_table :bounties do |t|
      t.references :clan
      t.index :clan_id
    end

  end
end
