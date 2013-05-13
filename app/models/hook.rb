class Hook < ActiveRecord::Base
  attr_accessible :description, :hook_name, :script

  has_many :hooktorepos#, :dependent => :destroy
	has_many :repositories, through: :hooktorepos
end
