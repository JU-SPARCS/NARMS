# db/migrate/017_create_safaps_responses.rb

class CreateSafapsResponses < ActiveRecord::Migration
  def self.up
    create_table :safaps_responses do |t|
      t.integer :id_evaluation
    	t.integer :stress_indicator
    	t.integer :fatigue_indicator
    	t.timestamps
    end
  end

  def self.down
    drop_table :safaps_responses
  end
end
