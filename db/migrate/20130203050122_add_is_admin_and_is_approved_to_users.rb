class AddIsAdminAndIsApprovedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :is_approved, :boolean
  end
end
