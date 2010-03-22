# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :authenticate 
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def load_navigation
    @course       = Course.find(params[:course_id]) if params[:course_id]
    @instructor   = Instructor.find(params[:instructor_id]) if params[:instructor_id]
    @project      = Project.find(params[:project_id]) if params[:project_id]
    
    # replace this code below
    case params[:term]
      when "spring2010"
        term_filter = @term = "Spring 2010"
      when "fall2009"
        term_filter = @term = "Fall 2009"
      when "spring2009"
        term_filter = @term = "Spring 2009"
      when "fall2008"
        term_filter = @term = "Fall 2008"
      else
        term_filter = "%"
    end
    
    # end needed replace
    
    case params[:level]
      when "freshman"
        level_filter = @level = "Freshman"
      when "sophomore"
        level_filter = @level = "Sophomore"
      when "junior"
        level_filter = @level = "Junior"
      when "senior"
        level_filter = @level = "Senior"
      else
        level_filter = "%"
    end
    
    @course       = nil if ( @level && @course && @course.level != @level )
    @level        ||= @course.level.titleize if @course
    
    @courses      = Course.find(:all, :conditions => ["level LIKE ?", level_filter])
    # @projects     = @course.projects if @course
    
    
    
    @instructors  = Instructor.find(:all)
    
    instructor_filter = "%"
    instructor_filter = @instructor.id if @instructor
    
    @projects     = Project.find(:all, :include => :works, :order => 'projects.name ASC', :conditions => ["works.instructor_id LIKE ? AND projects.course_id = ?", instructor_filter, @course.id]) if @course
    @courses      = Course.find(:all, :include => :works, :order => 'courses.name ASC', :conditions => ["level LIKE ? AND works.instructor_id LIKE ?", level_filter, instructor_filter])
    @instructors  = Instructor.find(:all, :include => :courses, :order => 'instructors.name ASC', :conditions => ["courses.level LIKE ?", level_filter])
   
  end
  
  def hide?
    session[:hide]
  end
  helper_method :hide?
  
  private
     def authenticate
        authenticate_or_request_with_http_basic 'Department of Art, Belmont University - Student Work' do |id, password| 
            id == 'art' && password == '4606770'
        end
     end
     
     
end
