class Instructor < ActiveRecord::Base
  has_many :works
  has_many :syllabi
  has_many :courses, through: :works#, uniq: true
  has_many :projects, through: :works#, uniq: true
  
  validates_presence_of :name

  def to_s
    self.name
  end
end
