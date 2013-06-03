class Usermailinglist < ActiveRecord::Base
  attr_accessible :notification, :repo_id, :user_id

  validates_uniqueness_of :repo_id, :scope => :user_id
end
