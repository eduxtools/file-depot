class Work < ActiveRecord::Base
  has_many :student_works
  has_many :students, through: :student_works
  has_many :attachments, as: :parent
  belongs_to :project
  belongs_to :instructor
  belongs_to :course

  attr_accessor :student_ids, :temp_image_token

  validates_presence_of :instructor, :course, :project_id, :term
  

  def student_names
    self.students.map(&:name).join(', ')
  end


  # ----- legacy
  attr_accessor :instructor_name, :student_name, :project_name, :course_name
  def instructor_name
    self.instructor.try(:name)
  end
  def instructor_name=(value)
    self.instructor = Instructor.find_or_create_by(name: value) unless value.blank?
  end

  def student_name
    self.student.try(:name)
  end
  def student_name=(value)
    self.student = Student.find_or_create_by(name: value) unless value.blank?
  end

  def project_name
    self.project.try(:name)
  end
  def project_name=(value)
    self.project = Project.find_or_create_by(name: value) unless value.blank?
  end

  def course_name
    self.course.try(:name)
  end
  def course_name=(value)
    self.course = Course.find_or_create_by(name: value) unless value.blank?
  end
  # ----- end legacy
end
