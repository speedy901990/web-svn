class Repository < ActiveRecord::Base
  attr_accessible :repo_name, :description
  
  has_many :grouptorepos, :dependent => :destroy
  has_many :groups, through: :grouptorepos
end
