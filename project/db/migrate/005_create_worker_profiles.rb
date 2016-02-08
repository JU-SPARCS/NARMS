class CreateWorkerProfiles < ActiveRecord::Migration
  def self.up
    create_table :worker_profiles do |t|
      t.string   :pub_id
      t.boolean  :active, default: true

      t.string   :name
      t.string   :first_name
      t.datetime :date_of_birth

      t.boolean  :active, default: true
      
      t.timestamps

      # associations:
      t.integer  :facility_id
    end

    add_index :worker_profiles, :facility_id
  end

  def self.down
    drop_table :worker_profiles
  end
end
