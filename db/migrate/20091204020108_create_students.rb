class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :name
      t.integer :major_id
      t.integer :minor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
