class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :user_status
      
      t.timestamps
    end
  end

  def self.down
  	drop_table :users
  end	
end
