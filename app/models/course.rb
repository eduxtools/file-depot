class Course < ActiveRecord::Base
  has_many :works
  has_many :projects

  def to_s
    self.name
  end

  def number_and_name
    "#{self.number} - #{self.name}"
  end
end
