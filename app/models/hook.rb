class Hook < ActiveRecord::Base
  attr_accessible :description, :hook_name, :script

  validates_presence_of :hook_name, :on => :create
  
  has_many :hooktorepos#, :dependent => :destroy
	has_many :repositories, through: :hooktorepos
end
