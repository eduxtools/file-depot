class WorksController < ApplicationController
  # GET /works
  # GET /works.xml
    
  def index
    # @works = Work.all
    
    @works = Work.paginate( :page => params[:page], :per_page => 50, :order => 'created_at ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @works }
    end
  end

  # GET /works/1
  # GET /works/1.xml
  def show
    @work = Work.find(params[:id] )

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/new
  # GET /works/new.xml
  def new
    @work = Work.new
    @image = Image.new
    
    @work.instructor_name ||= session[:work][:instructor_name]  if session[:work]
    @work.course_name     ||= session[:work][:course_name]      if session[:work]
    @work.course_name     ||= params[:course]                   if params[:course]
    @work.project_name    ||= session[:work][:project_name]     if session[:work]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/1/edit
  def edit
    @work = Work.find(params[:id])
  end

  # POST /works
  # POST /works.xml
  def create
    # @image = Image.new(params[:image])
    # @work = @image.work = Work.new(params[:work])
    # 
    #     
    # # ----
    # 
    # @image = Image.new
    # params[:image_data] ||= []
    # params[:image_data].each do |file|
    #   @image = Image.new({:uploaded_data => file}) unless file == ""
    # end
    
    
    success_count = file_count = 0    
    @work = Work.new(params[:work])
    session[:work] = params[:work]
    
    @work.project.course_id = @work.course.id if @work.course != nil
        
    respond_to do |format|
      if @work.save              
            # Image processing
            #
            @image = Image.new
            params[:image_data] ||= []
            params[:image_data].each do |file|
              if file != ""
                file_count = file_count + 1
                @image = Image.new({:uploaded_data => file, :work_id => @work.id })
                if @image.save
                  success_count = success_count + 1 
                end
              end
            end
            flash[:success_count] = success_count
            flash[:file_count] = file_count
            
            # File uploading
            #
            success_count = file_count = 0

            @file = OtherFile.new
            params[:file_data] ||= []
            params[:file_data].each do |file|
              if file != ""
                file_count = file_count + 1
                @file = OtherFile.new({:uploaded_data => file, :work_id => @work.id })
                if @file.save
                  success_count = success_count + 1 
                end
              end
            end
            flash[:alt_success_count] = success_count
            flash[:alt_file_count] = file_count
            
        # flash[:notice] = 'Student Work was successfully created.'
        format.html { redirect_to(@work) }
        format.xml  { render :xml => @work, :status => :created, :location => @work }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /works/1
  # PUT /works/1.xml
  def update
    @work = Work.find(params[:id])

    respond_to do |format|
      if @work.update_attributes(params[:work])
        flash[:notice] = 'Work was successfully updated.'
        format.html { redirect_to(@work) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.xml
  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to(works_url) }
      format.xml  { head :ok }
    end
  end
end
