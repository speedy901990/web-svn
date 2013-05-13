class CreateHooktorepos < ActiveRecord::Migration
  def change
    create_table :hooktorepos do |t|
	t.references :hook
    t.references :repository
    
    t.timestamps
    end
  end
  
  def self.down
  	drop_table :hooktorepos
  end	
end
