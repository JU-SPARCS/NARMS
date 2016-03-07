class CreateThirdPartiesRecipientOrganizations < ActiveRecord::Migration
  def self.up
    create_table :third_parties_recipients_organizations do |t|
      t.string   :name
      
      t.timestamps

      # associations
      t.integer  :recipient_id
    end
  end

  def self.down
    drop_table :third_parties_recipients_organizations
  end
end
