class Image < ActiveRecord::Base
  belongs_to :work
  has_one :course, :through => :work
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :size => 0.kilobytes..21144.kilobytes, 
                 :thumbnails => { :thumb => '100x100>', :medium => '950x700>', :large => '1200x900', :xlarge => '2000x2000' },
                 :processor => 'Rmagick'

  validates_as_attachment
  
end
