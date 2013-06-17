class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :metric_id
      t.integer :value, default: 1

      t.timestamps
    end

    add_column :events, :data, :hstore

    execute "CREATE INDEX events_gin_data ON events USING GIN(data)"
  end
end
