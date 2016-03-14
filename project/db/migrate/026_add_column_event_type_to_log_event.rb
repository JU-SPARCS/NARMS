class AddColumnEventTypeToLogEvent < ActiveRecord::Migration
  def self.up
    change_table :events_logs do |t|
      t.string :event_type
    end
  end

  def self.down
    change_table :events_logs do |t|
      t.remove :event_type
    end
  end
end
