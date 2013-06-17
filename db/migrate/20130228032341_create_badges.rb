class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :tag
      t.string :description
      t.string :related_metric
      t.integer :position, default: 0
      t.boolean :enabled, default: true
      t.timestamps
    end
  end
end
