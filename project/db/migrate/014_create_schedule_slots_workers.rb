class CreateScheduleSlotsWorkers < ActiveRecord::Migration
  def self.up
    create_table :schedule_slots_workers do |t|
      t.datetime :begin
      t.datetime :end
      
      t.timestamps

      # associations
      t.integer :schedules_worker_id
    end
  end

  def self.down
    drop_table :schedule_slots_workers
  end
end
