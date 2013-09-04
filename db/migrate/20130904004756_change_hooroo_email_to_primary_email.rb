class ChangeHoorooEmailToPrimaryEmail < ActiveRecord::Migration
  def change
    rename_column :users, :hooroo_email, :primary_email
  end
end
