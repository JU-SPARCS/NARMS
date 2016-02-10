class CreateShifts < ActiveRecord::Migration
  def self.up
    create_table :shifts do |t|
      t.datetime :begin
      t.datetime :end
      t.string   :name

      t.timestamps

      # associations
      t.integer  :facility_id
    end
  end

  def self.down
    drop_table :shifts
  end
end
