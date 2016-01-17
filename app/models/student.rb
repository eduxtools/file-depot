class Student < ActiveRecord::Base
  has_many :student_works
  has_many :works, through: :student_works

  validates_presence_of :name

  def to_s
    self.name
  end
end
