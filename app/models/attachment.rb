class Attachment < ActiveRecord::Base
  belongs_to :parent, polymorphic: true

  has_attached_file :file, whiny: false, default_url: "/images/:style/missing.png", 
    styles: { 
      large: "1200x900>",
      medium: "950x700>", 
      small: "300x300>", 
      thumb: "100x100>" 
    }
  do_not_validate_attachment_file_type :file
  # validates_attachment_content_type :file, content_type: /\*/

  def temp_id=(id)
    write_attribute(:parent_id, id)
    write_attribute(:parent_type, 'temp')    
  end
end
