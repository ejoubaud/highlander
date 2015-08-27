class CreateEnvatoService < ActiveRecord::Migration
  def change
    create_table :envato_services do |t|
      t.string :username, null: false
      t.timestamps
    end
  end
end
