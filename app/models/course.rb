class Course < ActiveRecord::Base
  has_many :works
  has_many :projects
  has_many :syllabi

  validates_presence_of :name, :number, :level, :credit_hours

  def to_s
    self.name
  end

  def number_and_name
    "#{self.number} - #{self.name}"
  end
end
