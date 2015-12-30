class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  # GET /works
  # GET /works.json
  def index
    @works = Work.all
  end

  # GET /works/1
  # GET /works/1.json
  def show
  end

  # GET /works/new
  def new
    previous_work = Work.find_by_id(session[:previous_work_id])

    @work = Work.new(
      instructor_id: previous_work.try(:instructor_id), 
      term: previous_work.try(:term),
      project_id: previous_work.try(:project_id),
      temp_image_token: Random.rand(10000000..999999999)
    )
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  # POST /works.json
  def create
    @work = Work.new(work_params)

    respond_to do |format|
      if @work.save
        set_student_work(params[:work][:student_ids], @work)
        create_new_project(work_params[:project_id], @work.course, @work)
        set_project_description(params[:project_description], @work.project)
        move_temp_ajax_images(@work)

        session[:previous_work_id] = @work.id

        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    respond_to do |format|
      if @work.update(work_params)
        set_student_work(params[:work][:student_ids], @work)

        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: 'Work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    def set_student_work(student_ids, work=@work)
      new_record_prefix = '::new_record::'
      student_ids = [student_ids] unless student_ids.is_a? Array
      student_ids = student_ids - [''] - [nil]

      unless student_ids.blank? 
        # clear previous
        work.student_works.clear

        # reassign students
        student_ids.each do |id|
          if id.to_s.start_with?(new_record_prefix) && id.to_s.gsub(new_record_prefix, '') != ''
            student = Student.create(name: id.to_s.gsub(new_record_prefix, ''))
            StudentWork.create(work: work, student_id: student.id)
          elsif !id.to_s.start_with?(new_record_prefix)
            StudentWork.create(work: work, student_id: id.to_i)
          end
        end
      end
    end

    def create_new_project(project_id, course, work=@work)
      new_record_prefix = '::new_record::'

      if course && project_id.to_s.start_with?(new_record_prefix)
        project = Project.create(name: project_id.to_s.gsub(new_record_prefix, ''), course_id: course.id)
        @work.project = project
        @work.save
      end
    end

    def set_project_description(description, project=@work.project)
      if !description.blank? && project
        project.update_attribute(:description, description)
      end
    end

    def filter_project_ids(project_id_params)
      project_id_params = [project_id_params] unless project_id_params.is_a? Array
      project_id_params = project_id_params - [''] - [nil]

      return project_id_params[0]
    end

    def move_temp_ajax_images(work=@work)
      Attachment.where(parent_id: work.temp_image_token, parent_type: 'temp').each do |attachment|
        attachment.parent = work
        attachment.save
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params['work']['project_id'] = filter_project_ids(params['work']['project_id'])
      return params.require(:work).permit(:name, :term, :description, :instructor_id, :student_ids, :attachment, :project_id, :course_id, :temp_image_token)
    end
end
