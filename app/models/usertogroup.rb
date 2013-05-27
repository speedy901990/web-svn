class Usertogroup < ActiveRecord::Base
   attr_accessible :user_id, :group_id

   	validates_uniqueness_of :user_id, :scope => :group_id
   belongs_to :user
   belongs_to :group
end
