class Attachment < ActiveRecord::Base
  belongs_to :parent, polymorphic: true

  has_attached_file :file, default_url: "/images/:style/missing.png", 
    styles: { 
      large: "1200x900>",
      medium: "950x700>", 
      small: "300x300>", 
      thumb: "100x100>" 
    }
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  def temp_id=(id)
    write_attribute(:parent_id, id)
    write_attribute(:parent_type, 'temp')    
  end
end
