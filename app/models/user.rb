class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :username, :email, :password, :password_confirmation
  validates :username, :presence => true, :length => 3..15, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }
end
