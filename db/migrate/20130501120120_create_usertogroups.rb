class CreateUsertogroups < ActiveRecord::Migration
  def change
    create_table :usertogroups do |t|
      t.references :group
      t.references :user
      t.timestamps
    end
  end

  def self.down
  	drop_table :usertogroups
  end	
end
