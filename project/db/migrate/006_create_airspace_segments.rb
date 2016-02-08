class CreateAirspaceSegments < ActiveRecord::Migration
  def self.up
    create_table :airspace_segments do |t|
      t.string   :pub_id
      t.boolean  :active, default: true

      t.string   :name

      t.timestamps

      # associations:
      t.integer  :facility_id
    end

    add_index :airspace_segments, :facility_id
  end

  def self.down
    drop_table :airspace_segments
  end
end
