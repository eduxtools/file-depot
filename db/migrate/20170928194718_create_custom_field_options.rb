class CreateCustomFieldOptions < ActiveRecord::Migration
  def change
    create_table :custom_field_options do |t|
      t.references :custom_field, index: true, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps null: false
    end
  end
end
