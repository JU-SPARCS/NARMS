class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :pub_id

      t.string  :name
      t.string  :first_name

      t.string  :email
      t.string  :crypted_password

      t.boolean :active, default: true
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
