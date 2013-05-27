class Grouptorepo < ActiveRecord::Base
  attr_accessible :group_id, :repository_id, :r, :w

  validates_uniqueness_of :group_id, :scope => :repository_id
	belongs_to :group
	belongs_to :repository
end
