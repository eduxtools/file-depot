class Browse::WorksController < ApplicationController
  layout 'browse'
  before_filter :load_navigation
  
  def index
    
    if ( @course || @instructor || params[:student_id] ) # @level was removed because sorting by all freshman takes a long time
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
    @work = @image.work
    
    
    # :conditions => ['courses.level LIKE ? AND course_id LIKE ? AND project_id LIKE ? AND instructor_id LIKE ? AND student_id LIKE ?', level, course_id, project_id, instructor_id, student_id ] )
    
    level         = ( @level ? @level : "%" )
    course_id     = ( @course ? @course.id : "%" )
    project_id    = ( @project ? @project.id : "%" )
    instructor_id = ( @instructor ? @instructor.id : "%" )
    student_id    = ( params[:student_id] ? params[:student_id] : "%" )
    # @next_image   = Image.find(:first, :include => [:work, :course], :conditions => ["id > #{@image.id} AND parent_id IS NULL" ])
    
    # @next_portfolio_item = PortfolioItem.find(:first, :order => 'position', :conditions => { :thumbnail => nil, :deleted => nil, :position_gt => @portfolio_item.position, :collection_id => @portfolio_item.collection_id, :account_id => session[:account_id] })
    
    works = Work.find(:all, :include => :course, :conditions => ['courses.level LIKE ? AND course_id LIKE ? AND project_id LIKE ? AND instructor_id LIKE ? AND student_id LIKE ?', level, course_id, project_id, instructor_id, student_id ] )
    
    image_array = Array.new
    works.each do |work|
  		work.images.each do |image|
  		  image_array << image.id
  		end
  	end
  	
  	image_array << image_array.slice(0)           # Puts the first image id at the end so that "next" can loop through the images
  	image_array.reverse! << image_array.slice(1)  # Puts the last image id at the end so that "prev" can loop through
  	image_array.reverse!                          # Restores the proper order from previous line
  
  	until image_array[1] == @image.id do
  	  image_array.shift
  	end
    @prev_image = image_array[0]
    @next_image = image_array[2]
    
    
    
  end
  
  def instructions
    
  end

  
end
