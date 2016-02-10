class AddShiftsWorkerProfilesTable < ActiveRecord::Migration
  def self.up
    # has_and_belongs_to_many association
    create_table   :shifts_worker_profiles, id: false do |t|
      t.belongs_to :shift,          index: true
      t.belongs_to :worker_profile, index: true
    end
  end

  def self.down
    drop_table :shifts_worker_profiles
  end
end
