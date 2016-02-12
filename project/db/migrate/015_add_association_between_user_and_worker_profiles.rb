class AddAssociationBetweenUserAndWorkerProfiles < ActiveRecord::Migration
  def self.up
    add_column :worker_profiles, :user_id, :integer
  end

  def self.down
    remove_column :worker_profiles, :user_id, :integer
  end
end
