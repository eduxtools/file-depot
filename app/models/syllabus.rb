class Syllabus < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :course

  has_attached_file :document
  validates_attachment_content_type :document, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
end
