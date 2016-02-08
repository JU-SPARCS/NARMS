class CreateFacilities < ActiveRecord::Migration
  def self.up
    create_table :facilities do |t|
      t.string   :pub_id
      t.boolean  :active, default: true

      t.string   :name
      t.string   :location

      t.timestamps
    end
  end

  def self.down
    drop_table :facilities
  end
end
