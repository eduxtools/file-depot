class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :student, index: true, foreign_key: true
      t.text :data, :limit => 4294967295

      t.timestamps null: false
    end
  end
end
