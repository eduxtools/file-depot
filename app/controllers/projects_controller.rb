class ProjectsController < ApplicationController
  def index
    course = Course.find_by_name(params[:course])
    @projects = Project.find(:all, :conditions => [ "name LIKE ? AND course_id LIKE ?", "%#{params[:search]}%", "#{course.id if course != nil}"])
  end
  
  def show
    @project = Project.find(params[:id])
    
    
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end

end
