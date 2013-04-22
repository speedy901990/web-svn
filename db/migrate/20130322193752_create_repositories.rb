class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :repo_name
      t.string :description

      t.timestamps
    end
  end
  
  def self.down
  	drop_table :repositories
  end	
end
