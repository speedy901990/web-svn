class Repository < ActiveRecord::Base
  attr_accessible :repo_name, :description
  
  validates_presence_of :repo_name, :on => :create
  validates_uniqueness_of :repo_name

  has_many :grouptorepos, :dependent => :destroy
  has_many :groups, through: :grouptorepos

  has_many :hooktorepos
end
