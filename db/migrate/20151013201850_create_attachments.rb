
class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments do |t|
      t.references :parent, polymorphic: true, index: true
      t.timestamps null: false
    end

    add_attachment :attachments, :file
  end

  def down
    drop_table :attachments
  end
end
