class AddCourseToWork < ActiveRecord::Migration
  def self.up
    add_column :works, :course_id, :integer
  end

  def self.down
    remove_column :works, :course_id
  end
end
