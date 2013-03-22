class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :repo_name

      t.timestamps
    end
  end
end
