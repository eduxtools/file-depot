class CreateSyllabi < ActiveRecord::Migration
  def change
    create_table :syllabi do |t|
      t.string :term
      t.references :instructor, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_attachment :syllabi, :document
  end
end
