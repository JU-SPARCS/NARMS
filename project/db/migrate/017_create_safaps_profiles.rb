# db/migrate/017_create_safaps_profiles.rb

class CreateSafapsProfiles < ActiveRecord::Migration
  def self.up
    create_table :safaps_profiles do |t|
      t.datetime :created_at
      t.timestamps
    end
  end

  def self.down
    drop_table :safaps_profiles
  end
end
