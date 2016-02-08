class CreateWorkstations < ActiveRecord::Migration
  def self.up
    create_table :workstations do |t|
      t.string   :pub_id
      t.boolean  :active, default: true

      t.string   :name
      
      t.timestamps

      # associations:
      t.integer  :facility_id
    end

    add_index :workstations, :facility_id
  end

  def self.down
    drop_table :workstations
  end
end
