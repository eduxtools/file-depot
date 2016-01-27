class Project < ActiveRecord::Base
  belongs_to :course
  has_many :works
  has_many :instructors, through: :works #, uniq: true

  def to_s
    self.name
  end
end
