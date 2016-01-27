class CacheAttachmentDetails < ActiveRecord::Migration
  def up
    add_column :works, :has_attachments, :boolean, default: false
    add_column :works, :has_images, :boolean, default: false

    # update caches
    Work.find_each do |work|
      work.has_attachments  = work.attachments.any?
      work.has_images       = work.attachments.map(&:is_image?).include?(true)
      work.save
    end
  end

  def down
    remove_column :works, :has_attachments
    remove_column :works, :has_images
  end
end
