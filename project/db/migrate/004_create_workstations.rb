class CreateWorkstations < ActiveRecord::Migration
  def self.up
    create_table :workstations do |t|
      t.string   :pub_id
      t.boolean  :active, default: true

      t.string   :name
      
      t.timestamps
    end
  end

  def self.down
    drop_table :workstations
  end
end
