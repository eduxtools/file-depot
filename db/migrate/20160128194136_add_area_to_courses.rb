class AddAreaToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :area, :string
    add_index :courses, :area
  end
end
