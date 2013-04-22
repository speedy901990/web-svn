class CreateGrouptorepos < ActiveRecord::Migration
  def change
    create_table :grouptorepos do |t|
      t.references :group
      t.references :repository
      t.boolean :r
      t.boolean :w

      t.timestamps
    end
  end
  
  def self.down
  	drop_table :grouptorepos
  end	
end
