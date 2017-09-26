class SubmissionsController < ApplicationController
  skip_before_action :login_required
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :login_required, except: [:new, :create] # SubmissionsController overrides the normal method, but must come after `set_submission`


  layout 'submit'

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @previous_submission = Submission.find_by_id(session[:previous_submission_id])
    @submission = Submission.new(temp_image_token: Random.rand(10000000..999999999))
    @submission.build_student()

    if @previous_submission
      CustomField.where(persistent: true).each do |custom_field|
        @submission.data[custom_field.name] = @previous_submission.data[custom_field.name]
      end
    end
  end

  # GET /submissions/1/edit
  def edit
    @submission.temp_image_token = Random.rand(10000000..999999999)
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        move_temp_ajax_images(@submission)
        session[:previous_submission_id] = @submission.id

        # Store uploaded submissions from this session
        # This allows these submissions to be viewed or edited without logging
        session[:uploaded_submission_ids] ||= []
        session[:uploaded_submission_ids] << @submission.id

        format.html { redirect_to @submission, notice: 'Submission was successfully uploaded.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        move_temp_ajax_images(@submission)

        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:temp_image_token, data: CustomField.fields, student_attributes: [:id, :name])
    end

    def move_temp_ajax_images(submission=@submission)
      Attachment.where(parent_id: submission.temp_image_token, parent_type: 'temp').each do |attachment|
        attachment.parent = submission
        attachment.save
      end
    end

    # This overrides the normal login behavior to allow viewing and editing of submissions uploaded during this session
    def login_required
      session[:uploaded_submission_ids] ||= [] # in case it hasn't yet been set

      if @submission && session[:uploaded_submission_ids].include?(@submission.id)
        # return true will simply allow the application to continue, ignoring the normal login method (return true does not mean that login is required)
        return true
      else
        super
      end
    end
end
