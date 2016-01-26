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

  def temp_id=(id)
    write_attribute(:parent_id, id)
    write_attribute(:parent_type, 'temp')    
  end

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

  def format_for_web(geometry)
    web_formats           = ['.jpg', '.jpeg', '.png', '.gif']
    options               = {}
    options[:geometry]    = geometry
    options[:format]      = :png if !web_formats.include?(File.extname(self.file_file_name))
    return options
  end


end
