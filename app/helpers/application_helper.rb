# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def tooltip(name, message)
    
    "<div id=\"#{name}_tooltip\" class=\"tooltip\" style=\"display: none; height: auto;\">
			<div class=\"top\"></div>
			<div class=\"middle\">#{message}</div>
			<div class=\"bottom\"></div>
		</div>"
    
  end
end
