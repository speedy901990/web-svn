class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :group_name
      t.string :description
      
      t.timestamps
    end
  end
  
  def self.down
  	drop_table :groups
  end	
end
