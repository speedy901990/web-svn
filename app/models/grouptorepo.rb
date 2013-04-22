class Grouptorepo < ActiveRecord::Base
  attr_accessible :group_id, :repository_id, :r, :w
	belongs_to :group
	belongs_to :repository
end
