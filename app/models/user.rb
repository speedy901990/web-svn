require "digest"

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :is_admin, :apache_hash
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    par_user = email
    par_password = password
  if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
   # if user && user.password_hash == Digest::MD5.hexdigest(password)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      par_user = email
      par_password = password
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      self.apache_hash = %x[script/generate_hash.sh #{par_user} #{par_password}]
    end
  end

  has_many :usertogroups, :dependent => :destroy
  has_many :groups, through: :usertogroups
end
