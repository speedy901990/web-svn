class Group < ActiveRecord::Base
  attr_accessible :group_name, :description
  has_many :grouptorepos#, :dependent => :destroy
	has_many :repositories, through: :grouptorepos
end
