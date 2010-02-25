class Student < ActiveRecord::Base
  has_many :works
  
  validates_uniqueness_of :name
end
