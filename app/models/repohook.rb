class Repohook < ActiveRecord::Base
  attr_accessible :hook_name, :repository_id
	belongs_to :repository
end
