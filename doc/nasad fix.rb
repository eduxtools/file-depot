# where 'work.course_id' does not equal 'work.project.course_id'
#
# 	then look up project by name (work.project.name) and course_id (work.course_id)
#	
# 	if none exists then create new project and set work.project_id to new project
#	
# 	if project does exists set work.project_id to found project
	


works = Work.find(:all, :include => ['course', 'project'])

works.each do |w|
  if w.course_id != w.project.course_id
    project = Project.find_or_create_by_name_and_course_id(w.project.name, w.course_id)
    w.project_id = project.id
    w.save
  end
end
