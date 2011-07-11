class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.timestamps
    end

    add_index :admins, :email, :unique => true
    add_index :admins, :username, :unique => true
  end

  def self.down
    drop_table :admins
  end
end
