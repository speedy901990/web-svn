class Repository < ActiveRecord::Base
  attr_accessible :repo_name, :description
  
  has_and_belongs_to_many :groups, :dependant => :destroy
end
