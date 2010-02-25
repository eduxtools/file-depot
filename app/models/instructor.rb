class Instructor < ActiveRecord::Base
  has_many :works
  has_many :syllabus_files
  
end
