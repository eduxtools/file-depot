class Instructor < ActiveRecord::Base
  has_many :works
  has_many :syllabus_files
  has_many :courses, :through => :works, :uniq => true
  has_many :projects, :through => :works, :uniq => true
  
  # , :uniq => true
end
