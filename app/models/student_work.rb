class StudentWork < ActiveRecord::Base
  belongs_to :student
  belongs_to :work
end
