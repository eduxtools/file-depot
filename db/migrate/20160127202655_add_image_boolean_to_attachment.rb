class AddImageBooleanToAttachment < ActiveRecord::Migration
  def up
    add_column :attachments, :has_image, :boolean, default: true

    Attachment.find_each do |attachment|
      attachment.update_column(:has_image, attachment.is_image?)
    end
  end

  def down
    remove_column :attachment, :has_image
  end
end
