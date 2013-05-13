class Hooktorepo < ActiveRecord::Base
  attr_accessible :hook_id, :repository_id
	belongs_to :hook
	belongs_to :repository
end
