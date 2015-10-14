class RemoveCoursePrefixFromCourseColumns < ActiveRecord::Migration
  def change
    rename_column :courses, :course_number, :number
    rename_column :courses, :course_description, :description
  end
end
