class AddViewPermissionsIntoPermissionsTableShiftManagement < ActiveRecord::Migration
  def self.up
    change_table :permissions_tables_shift_managements do |t|
      t.string :view_atco_worker_schedule
      t.string :view_atco_worker_log_event
  	end
  end

  def self.down
  	change_table :permissions_tables_shift_managements do |t|
      t.remove :manage_atco_safaps_categories
  	end
  end
end
