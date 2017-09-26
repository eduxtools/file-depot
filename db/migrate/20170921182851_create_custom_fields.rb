class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.string :name
      t.boolean :required, default: false
      t.boolean :persistent, default: false
      t.integer :position

      t.timestamps null: false
    end
  end
end
