class OtherFilesController < ApplicationController
  # GET /other_files
  # GET /other_files.xml
  def index
    @other_files = OtherFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @other_files }
    end
  end

  # GET /other_files/1
  # GET /other_files/1.xml
  def show
    @other_file = OtherFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @other_file }
    end
  end

  # GET /other_files/new
  # GET /other_files/new.xml
  def new
    if params[:work_id]
       @other_file = OtherFile.new
       @work = Work.find(params[:work_id])
     else
       redirect_to(works_url)
     end
  end

  # GET /other_files/1/edit
  def edit
    @other_file = OtherFile.find(params[:id])
  end

  # POST /other_files
  # POST /other_files.xml
  def create
    # Based on Image Controller Create
    
    success_count = file_count = 0
    @work = Work.find(params[:work][:id])
    
    # Image processing -- atypical validations 
    #
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
    redirect_to work_url(@work)
  end

  # PUT /other_files/1
  # PUT /other_files/1.xml
  def update
    @other_file = OtherFile.find(params[:id])

    respond_to do |format|
      if @other_file.update_attributes(params[:other_file])
        flash[:notice] = 'OtherFile was successfully updated.'
        format.html { redirect_to(@other_file) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @other_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /other_files/1
  # DELETE /other_files/1.xml
  def destroy
    @other_file = OtherFile.find(params[:id])
    @other_file.destroy

    respond_to do |format|
      format.html { redirect_to(other_files_url) }
      format.xml  { head :ok }
    end
  end
end
