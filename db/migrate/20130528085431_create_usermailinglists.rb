class CreateUsermailinglists < ActiveRecord::Migration
  def change
    create_table :usermailinglists do |t|
      t.integer :user_id
      t.integer :repo_id
      t.boolean :notification

      t.timestamps
    end
  end

  def self.down
        drop_table :usermailinglists
  end

end
