class CreateGroupsToRepos < ActiveRecord::Migration
  def change
    create_table :groups_to_repos do |t|
      t.boolean :r
      t.boolean :w
      t.integer :group_id
      t.integer :repository_id

      t.timestamps
    end
  end
end
