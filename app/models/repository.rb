class Repository < ActiveRecord::Base
  attr_accessible :repo_name
  
  def self.return_items
    find(:all)
  end
end
