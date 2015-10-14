class Work < ActiveRecord::Base
  belongs_to :student
  belongs_to :project
  belongs_to :instructor
  belongs_to :course
  has_many :images
  has_many :other_files
  
  validates_presence_of :term, :course_name, :instructor_name, :project_name, :student_name
  
  def student_name
    student.name if student
  end

  def student_name=(name)
    self.student = Student.find_or_create_by_name(name) unless name.blank?
  end
  
  def instructor_name
    instructor.name if instructor
  end
  
  def instructor_name=(name)
    self.instructor = Instructor.find_or_create_by_name(name) unless name.blank?
  end
  
  def project_name
    project.name if project
  end
  
  def project_name=(name)
    self.project = Project.find_or_initialize_by_name_and_course_id(name, self.course.id) unless name.blank?
  end
  
  def course_name
    course.name if course
  end
  
  def course_name=(name)
    self.course = Course.find_or_create_by_name(name) unless name.blank?
  end
  
end
