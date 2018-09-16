class Attachment < ActiveRecord::Base
  belongs_to :parent, polymorphic: true

  has_attached_file :file, whiny: false, default_url: "/images/:style/missing.png",
                    styles: lambda { |file| {
                                large:  file.instance.format_for_web("1200x900>"),
                                medium: file.instance.format_for_web("950x700>"),
                                small:  file.instance.format_for_web("300x300>"),
                                thumb:  file.instance.format_for_web("100x100>"),
                              }
                            }
  do_not_validate_attachment_file_type :file
  # validates_attachment_content_type :file, content_type: /\*/

  before_save :update_image_cache
  after_save :update_work_caches
  before_destroy :update_work_caches_after_delete

  def temp_id=(id)
    write_attribute(:parent_id, id)
    write_attribute(:parent_type, 'temp')
  end

  # has_image returns cached boolean

  def is_image?
    [
      'image/jpg',
      'image/jpeg',
      'image/pjpeg',
      'image/png',
      'image/x-png',
      'image/gif',
      'image/svg+xml',
      'image/tiff',
      'image/pict',
      'image/vnd.microsoft.icon',
      'image/vnd.adobe.photoshop',
      'application/x-photoshop',
      'application/postscript',
      'application/pdf'
    ].include?(self.file_content_type)
  end

  def is_pdf?
    [
      'application/postscript',
      'application/pdf'
    ].include?(self.file_content_type)
  end

  def format_for_web(geometry)
    web_formats           = ['.jpg', '.jpeg', '.png', '.gif']
    options               = {}
    options[:geometry]    = geometry
    options[:format]      = :png if !web_formats.include?(File.extname(self.file_file_name))
    return options
  end

  private
    def update_image_cache
      has_image = self.is_image?
    end

    def update_work_caches
      if parent_type != 'temp' && parent && parent.class == Work
        parent.has_attachments = true
        parent.has_images      = true if self.is_image?
        parent.save
      end
    end

    def update_work_caches_after_delete
      if parent_type != 'temp' && parent && parent.class == Work
        other_attachments      = (parent.attachments - self)
        parent.has_attachments = other_attachments.any?
        parent.has_images      = other_attachments.any? && other_attachments.map(&:is_image?).include?(true)
        parent.save
      end
    end


end
