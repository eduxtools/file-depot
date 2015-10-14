class Project < ActiveRecord::Base
  belongs_to :course
  has_many :works

  def to_s
    self.name
  end
end
