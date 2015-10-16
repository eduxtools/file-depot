class Syllabus < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :course

  has_attached_file :document
  validates_attachment_content_type :document, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']

  def as_json(options={})
    default_include = {:instructor => {:only => :name}, :course => {:only => :name}}
    options[:include] = options[:include] ? default_include.merge(options[:include]) : default_include 

    super(options)
  end
end
