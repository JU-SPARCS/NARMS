# db/migrate/017_create_safaps_requests.rb

class CreateSafapsRequests < ActiveRecord::Migration
  def self.up
    create_table :safaps_requests do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :safaps_requests
  end
end
