class ChangePreferredEmailToHoorooEmail < ActiveRecord::Migration
  def change
    rename_column :users, :preferred_email, :primary_email
  end
end
