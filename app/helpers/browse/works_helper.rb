module Browse::WorksHelper
  
  def work_title(work)
    work.project ? work.project : work.course
  end

  # Legacy
  def image_height(parent_id, thumbnail_name)
    Image.find_by_parent_id(parent_id, :conditions => { :thumbnail => thumbnail_name } ).height
  end
  
  def image_width(parent_id, thumbnail_name)
    Image.find_by_parent_id(parent_id, :conditions => { :thumbnail => thumbnail_name } ).width
  end
  
end
