class CreateHooks < ActiveRecord::Migration
  def change
    create_table :hooks do |t|
      t.string :hook_name
      t.string :description

      t.timestamps
    end
  end

  def self.down
  	drop_table :hooks
  end	
end
