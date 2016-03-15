class RenameFieldsInSchedulesWorker < ActiveRecord::Migration
  def self.up
    rename_column :schedules_workers, :begin, :begin_at
    rename_column :schedules_workers, :end, :end_at
  end

  def self.down
    rename_column :schedules_workers, :begin_at, :begin
    rename_column :schedules_workers, :end_at, :end
  end
end
