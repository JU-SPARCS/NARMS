class AddFieldToShiftmanagementPermissionTable < ActiveRecord::Migration
  def self.up
    change_table :permissions_tables_shift_managements do |t|
      t.string :view_shift_schedule
  	end
  end

  def self.down
  	change_table :permissions_tables_shift_managements do |t|
      t.remove :view_shift_schedule
  	end
  end
end
