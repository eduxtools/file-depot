class Attachment < ActiveRecord::Base
  belongs_to :parent, polymorphic: true

  has_attached_file :attachment, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/

  def temp_id=(id)
    write_attribute(:parent_id, id)
    write_attribute(:parent_type, 'temp')    
  end
end
