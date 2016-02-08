class CreateEventsLogs < ActiveRecord::Migration
  def self.up
    create_table :events_logs do |t|
      t.datetime :happened_at

      t.string   :worker_role
      t.string   :worker_responsability
      t.string   :operational_status

      t.timestamps

      # associations:
      t.integer  :workstation_id
      t.integer  :worker_profile_id
    end

    add_index :events_logs, :workstation_id
    add_index :events_logs, :worker_profile_id
  end

  def self.down
    drop_table :events_logs
  end
end
