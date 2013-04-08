class CreateHooks < ActiveRecord::Migration
  def change
    create_table :hooks do |t|
      t.string :hook_name
      t.string :description

      t.timestamps
    end
  end
end
