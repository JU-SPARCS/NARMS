class CreateThirdPartiesRecipients < ActiveRecord::Migration
  def self.up
    create_table :third_parties_recipients do |t|
      t.string   :name
      
      t.timestamps
    end
  end

  def self.down
    drop_table :third_parties_recipients
  end
end
