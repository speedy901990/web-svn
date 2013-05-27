class CreateRepohooks < ActiveRecord::Migration
  def change
    create_table :repohooks do |t|
	  t.string :hook_name
    t.references :repository
    
    t.timestamps
    end
  end
  
  def self.down
  	drop_table :repohooks
  end	
end