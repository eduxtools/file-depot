class OtherFile < ActiveRecord::Base
  belongs_to :work
  
  has_attachment :storage => :file_system, 
                 :size => 0.kilobytes..21144.kilobytes

  validates_as_attachment
  
end
