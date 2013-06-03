class Usermailinglist < ActiveRecord::Base
  attr_accessible :notification, :repo_id, :user_id
end
