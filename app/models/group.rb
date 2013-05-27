class Group < ActiveRecord::Base
  attr_accessible :group_name, :description

  validates_presence_of :group_name, :on => :create
   validates_uniqueness_of :group_name
  
  has_many :grouptorepos#, :dependent => :destroy
	has_many :repositories, through: :grouptorepos

	has_many :usertogroups#, :dependent => :destroy
	has_many :users, through: :usertogroups
end
