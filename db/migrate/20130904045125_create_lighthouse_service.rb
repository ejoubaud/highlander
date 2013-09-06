class CreateLighthouseService < ActiveRecord::Migration
  def change
    create_table :lighthouse_services do |t|
     t.string :username, null: false
     t.timestamps
    end
  end
end
