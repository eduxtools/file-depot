class CreateSyllabusFiles < ActiveRecord::Migration
  def self.up
    create_table :syllabus_files do |t|
      t.string :semester
      t.integer :instructor_id
      t.integer :course_id
      t.integer :parent_id
      t.string :content_type
      t.string :filename
      t.string :thumbnail
      t.integer :size
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :syllabus_files
  end
end
