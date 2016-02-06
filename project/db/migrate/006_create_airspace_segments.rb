class CreateAirspaceSegments < ActiveRecord::Migration
  def self.up
    create_table :airspace_segments do |t|
      t.string   :pub_id
      t.boolean  :active, default: true

      t.string   :name

      t.timestamps
    end
  end

  def self.down
    drop_table :airspace_segments
  end
end
