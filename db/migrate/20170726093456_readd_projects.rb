class ReaddProjects < ActiveRecord::Migration
  def up
    # Projects table migration had been missing,
    # so this fixes the migration for new builds
    #
    unless ActiveRecord::Base.connection.table_exists? 'projects'
      create_table :projects do |t|
        t.string :name
        t.text :description
        t.integer :course_id

        t.timestamps
      end

      add_index :projects, :course_id
    end
  end

  def down
    drop_table :projects
  end
end
