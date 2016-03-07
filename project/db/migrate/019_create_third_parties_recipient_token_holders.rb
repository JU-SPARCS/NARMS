class CreateThirdPartiesRecipientTokenHolders < ActiveRecord::Migration
  def self.up
    create_table :third_parties_recipients_token_holders do |t|
      t.string   :name
      t.string   :token
      
      t.timestamps

      # associations
      t.integer  :organization_id
      t.integer  :tokenable_r_id
      t.string   :tokenable_r_type
    end
  end

  def self.down
    drop_table :third_parties_recipients_token_holders
  end
end
