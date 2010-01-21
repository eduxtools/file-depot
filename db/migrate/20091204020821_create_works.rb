class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.string :name
      t.string :semester
      t.text :description
      t.integer :student_id
      t.integer :project_id
      t.integer :instructor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :works
  end
end
