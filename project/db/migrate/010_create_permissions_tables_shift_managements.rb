class CreatePermissionsTablesShiftManagements < ActiveRecord::Migration
  def self.up
    create_table :permissions_tables_shift_managements do |t|
      t.string :conduct_safaps_assessment,          default: "nobody"
      t.string :prepare_shift_schedule,             default: "nobody"
      t.string :view_atco_safaps_shift_inputs,      default: "nobody"
      t.string :view_atco_safaps_shift_assessments, default: "nobody"
      t.string :manage_atco_safaps_categories,      default: "nobody"
      
      t.timestamps

      # associations:
      t.integer :role_id
    end
    add_index :permissions_tables_shift_managements, :role_id
  end

  def self.down
    remove_index :permissions_tables_shift_managements, :role_id
    drop_table :permissions_tables_shift_managements
  end
end
