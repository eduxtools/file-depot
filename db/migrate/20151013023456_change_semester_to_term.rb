class ChangeSemesterToTerm < ActiveRecord::Migration
  def change
    rename_column :works, :semester, :term
    rename_column :syllabus_files, :semester, :term
  end
end
