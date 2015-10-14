class CreateStudentWorks < ActiveRecord::Migration
  def up
    create_table :student_works do |t|
      t.references :student, index: true, foreign_key: true
      t.references :work, index: true, foreign_key: true

      t.timestamps null: false
    end

    Work.find_each do |work|
      StudentWork.create(work_id: work.id, student_id: work.student_id)
    end

    remove_column :works, :student_id
  end

  def down
    # MIGRATION NOTE: This will remove any student other than the first student associated to any work
    add_column :works, :student_id, :integer

    Work.find_each do |work|
      work.update_column(:student_id, work.students.first.try(:id))
    end

    drop_table :student_works
  end
end
