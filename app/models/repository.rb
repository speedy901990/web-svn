class Repository < ActiveRecord::Base
  attr_accessible :repo_name, :description
  
  def self.return_items
    find(:all)
  end
end
