# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def tooltip(name, message)
    
    "<div id=\"#{name}_tooltip\" class=\"tooltip\" style=\"display: none; height: auto;\">
			<div class=\"top\"></div>
			<div class=\"middle\">#{message}</div>
			<div class=\"bottom\"></div>
		</div>"
    
  end
  
  def browse_nav_link_to(name, options = {}, html_options = {})
    options = { 
      :term => params[:term],
      :course_id => params[:course_id], 
      :instructor_id => params[:instructor_id], 
      :project_id => params[:project_id], 
      :student_id => params[:student_id], 
      :level => params[:level] 
    }.merge(options)
    link_to name, browse_works_url(options), html_options
  end 
end
