class AddAssociationBetweenRoleAndUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role_id, :integer
    add_index  :roles, :name
  end

  def self.down
    remove_column :users, :role_id, :integer
    remove_index  :roles, :name
  end
end
