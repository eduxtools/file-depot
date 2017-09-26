class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :name, :email, :password, :password_confirmation
  validates :email, :format => { :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
end
