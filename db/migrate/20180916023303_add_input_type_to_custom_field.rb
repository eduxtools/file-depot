class AddInputTypeToCustomField < ActiveRecord::Migration
  def change
    add_column :custom_fields, :input_type, :string, default: "string"
  end
end
