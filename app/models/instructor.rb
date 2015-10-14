class Instructor < ActiveRecord::Base
  has_many :works

  def to_s
    self.name
  end
end
