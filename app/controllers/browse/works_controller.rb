class Browse::WorksController < ApplicationController
  layout 'browse'
  before_filter :load_navigation
  
  def index
    
    if (@level || @course || @instructor || params[:student_id] )
      level         = ( @level ? @level : "%" )
      course_id     = ( @course ? @course.id : "%" )
      project_id    = ( @project ? @project.id : "%" )
      instructor_id = ( @instructor ? @instructor.id : "%" )
      student_id    = ( params[:student_id] ? params[:student_id] : "%" )
      @works = Work.find(:all, :include => :course, :conditions => ['courses.level LIKE ? AND course_id LIKE ? AND project_id LIKE ? AND instructor_id LIKE ? AND student_id LIKE ?', level, course_id, project_id, instructor_id, student_id ] )
    else
      render :action => "instructions"
    end
  end
  
  def show
    @image = Image.find(params[:id], :include => 'work')
  end
  
  def instructions
    
  end

  
end
