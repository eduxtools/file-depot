class Browse::WorksController < ApplicationController
  layout 'browse'
  before_filter :load_navigation
  
  def index
    
    if (params[:level] || params[:course_id] || params[:instructor_id] || params[:course_id] || params[:student_id] )
      course_id     = ( params[:course_id] ? params[:course_id] : "%" )
      instructor_id = ( params[:instructor_id] ? params[:instructor_id] : "%" )
      student_id    = ( params[:student_id] ? params[:student_id] : "%" )
      @works = Work.find(:all, :conditions => ['course_id LIKE ? AND instructor_id LIKE ? AND student_id LIKE ?', course_id, instructor_id, student_id ] )
    else
      render :action => "instructions"
    end
  end
  
  def instructions
    
  end

  def show
  end
end
