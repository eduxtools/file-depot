class Image < ActiveRecord::Base
  belongs_to :work
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :size => 0.kilobytes..21144.kilobytes, 
                 :thumbnails => { :thumb => '100x100>', :medium => '950x700>', :large => '1000x800', :xlarge => '3000x3000' },
                 :processor => 'Rmagick'

  validates_as_attachment
  
end
