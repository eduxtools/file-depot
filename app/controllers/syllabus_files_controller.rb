class SyllabusFilesController < ApplicationController
  # GET /syllabus_files
  # GET /syllabus_files.xml
  def index
    @syllabus_files = SyllabusFile.paginate( :page => params[:page], :per_page => 50, :order => 'created_at DESC', :conditions => ['course_id LIKE ?', "#{params[:course_id] ? params[:course_id] : '%' }"] )
    @course = Course.find(params[:course_id]) if params[:course_id]
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @syllabus_files }
    end
  end

  # GET /syllabus_files/1
  # GET /syllabus_files/1.xml
  def show
    @syllabus_file = SyllabusFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @syllabus_file }
    end
  end

  # GET /syllabus_files/new
  # GET /syllabus_files/new.xml
  def new
    @syllabus_file = SyllabusFile.new
    
    @syllabus_file.instructor_name ||= session[:work][:instructor_name]  if session[:work]
    # @syllabus_file.course_name     ||= session[:work][:course_name]      if session[:work]
    @syllabus_file.course_name     ||= params[:course]                   if params[:course]
    # @syllabus_file.semester        ||= session[:work][:semester]         if session[:work]
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @syllabus_file }
    end
  end

  # GET /syllabus_files/1/edit
  def edit
    @syllabus_file = SyllabusFile.find(params[:id])
  end

  # POST /syllabus_files
  # POST /syllabus_files.xml
  def create
    @syllabus_file = SyllabusFile.new(params[:syllabus_file])
    
    session[:work][:instructor_name] = @syllabus_file.instructor_name
    
    respond_to do |format|
      if @syllabus_file.save
        flash[:notice] = 'SyllabusFile was successfully created.'
        format.html { redirect_to syllabus_files_path }
        # format.xml  { render :xml => @syllabus_file, :status => :created, :location => @syllabus_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @syllabus_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /syllabus_files/1
  # PUT /syllabus_files/1.xml
  def update
    @syllabus_file = SyllabusFile.find(params[:id])

    respond_to do |format|
      if @syllabus_file.update_attributes(params[:syllabus_file])
        flash[:notice] = 'SyllabusFile was successfully updated.'
        format.html { redirect_to syllabus_files_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @syllabus_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /syllabus_files/1
  # DELETE /syllabus_files/1.xml
  def destroy
    @syllabus_file = SyllabusFile.find(params[:id])
    @syllabus_file.destroy

    respond_to do |format|
      format.html { redirect_to(syllabus_files_url) }
      format.xml  { head :ok }
    end
  end
end
