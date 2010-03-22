class Project < ActiveRecord::Base
  belongs_to :course
  has_many :works
  has_many :instructors, :through => :works, :uniq => true
end

# class Instructor < ActiveRecord::Base
#   has_many :works
#   has_many :syllabus_files
#   has_many :courses, :through => :works, :uniq => true
#   has_many :projects, :through => :works, :uniq => true
# end
