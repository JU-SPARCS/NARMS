class CreateSchedulesWorkers < ActiveRecord::Migration
  def self.up
    create_table :schedules_workers do |t|
      t.datetime :begin
      t.datetime :end
      
      t.timestamps

      # associations
      t.integer  :worker_profile_id
    end
  end

  def self.down
    drop_table :schedules_workers
  end
end
