class RemoveMajorAndMinorReferencesFromStudents < ActiveRecord::Migration
  def up
    remove_column :students, :major_id
    remove_column :students, :minor_id
  end

  def down
    add_column :students, :major_id, :integer
    add_column :students, :minor_id, :integer
  end
end
