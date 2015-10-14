class Student < ActiveRecord::Base
  has_many :student_works
  has_many :works, through: :student_works

  def to_s
    self.name
  end
end
