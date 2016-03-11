class RenameFieldsInSchedulesSlotWorker < ActiveRecord::Migration
  def self.up
    rename_column :schedule_slots_workers, :begin, :begin_at
    rename_column :schedule_slots_workers, :end, :end_at
  end

  def self.down
    rename_column :schedule_slots_workers, :begin_at, :begin
    rename_column :schedule_slots_workers, :end_at, :end
  end
end
