class CacheWorksForCoursesAndInstructors < ActiveRecord::Migration
  def up
    add_column :courses, :has_works, :boolean, default: false
    add_column :instructors, :has_works, :boolean, default: false

    Course.find_each do |course|
      course.has_works = course.works.any?
      course.save
    end 

    Instructor.find_each do |instructor|
      instructor.has_works = instructor.works.any?
      instructor.save
    end 
  end

  def down
    remove_column :courses, :has_works
    remove_column :instructors, :has_works
  end
end
