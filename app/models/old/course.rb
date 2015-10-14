class Course < ActiveRecord::Base
  has_many :projects
  has_many :works
  has_many :syllabus_files
  has_many :images
  
  
  ## Cannont currently validate due to the fact that the course cannot be created in the work controller with a course number
  
  # validates_length_of :course_number, :is => 4, :message => "Course number should be 4 digits."
  # validates_presence_of :name
  
end
