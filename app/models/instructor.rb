class Instructor < ActiveRecord::Base
  has_many :works
  
  validates_presence_of :name

  def to_s
    self.name
  end
end
