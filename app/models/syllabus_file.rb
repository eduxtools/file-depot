class SyllabusFile < ActiveRecord::Base
  belongs_to :course
  belongs_to :instructor
  
  has_attachment :storage => :file_system, 
                 :size => 0.kilobytes..21144.kilobytes

  # validates_as_attachment
  validates_presence_of :semester, :course_name, :instructor_name, :filename
  
  def course_name
    course.name if course
  end
  
  def course_name=(name)
    self.course = Course.find_or_create_by_name(name) unless name.blank?
  end
  
  def instructor_name
    instructor.name if instructor
  end
  
  def instructor_name=(name)
    self.instructor = Instructor.find_or_create_by_name(name) unless name.blank?
  end
  
end
