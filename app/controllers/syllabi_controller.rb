class SyllabiController < ApplicationController
  before_action :set_syllabus, only: [:show, :edit, :update, :destroy]

  # GET /syllabi
  # GET /syllabi.json
  def index
    @syllabi = Syllabus.all
  end

  # GET /syllabi/1
  # GET /syllabi/1.json
  def show
  end

  # GET /syllabi/new
  def new
    @syllabus = Syllabus.new
  end

  # GET /syllabi/1/edit
  def edit
  end

  # POST /syllabi
  # POST /syllabi.json
  def create
    @syllabus = Syllabus.new(syllabus_params)

    processed_filename    = process_filename(@syllabus.document_file_name)
    @syllabus.course      = processed_filename[:course]
    @syllabus.instructor  = processed_filename[:instructor]
    @syllabus.term        = processed_filename[:term]


    respond_to do |format|
      if @syllabus.save
        format.html { redirect_to @syllabus, notice: 'Syllabus was successfully created.' }
        format.json { render json: @syllabus.as_json, status: :created, location: @syllabus }
      else
        format.html { render :new }
        format.json { render json: @syllabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /syllabi/1
  # PATCH/PUT /syllabi/1.json
  def update
    @syllabus.assign_attributes(syllabus_params)

    processed_filename    = process_filename(@syllabus.document_file_name)
    @syllabus.course      = processed_filename[:course]     if @syllabus.course.blank?
    @syllabus.instructor  = processed_filename[:instructor] if @syllabus.instructor.blank?
    @syllabus.term        = processed_filename[:term]       if @syllabus.term.blank?

    respond_to do |format|
      if @syllabus.save
        format.html { redirect_to @syllabus, notice: 'Syllabus was successfully updated.' }
        format.json { render :show, status: :ok, location: @syllabus }
      else
        format.html { render :edit }
        format.json { render json: @syllabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syllabi/1
  # DELETE /syllabi/1.json
  def destroy
    @syllabus.destroy
    respond_to do |format|
      format.html { redirect_to syllabi_url, notice: 'Syllabus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_syllabus
      @syllabus = Syllabus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def syllabus_params
      params.require(:syllabus).permit(:term, :instructor_id, :course_id, :document)
    end

    def process_filename(filename, options={})
      results = {}

      # determine Course
      filename.scan(/[A-Z]{3,4}[\s+_-]*?[\d]{3,4}/i).each do |pattern|
        # search pattern ABC 1234
        results[:course] ||= Course.where('lower(number) = ?', pattern.strip.gsub(/[\s+_-]/, ' ').downcase).first 
        # search pattern ABC1234
        results[:course] ||= Course.where('lower(number) = ?', pattern.gsub(/[\s+_-]/, '').downcase).first
      end

      # determine instructor
      possible_names = []
      instructor_names = Instructor.all.map(&:name).join(' ').split(' ')
      instructor_names.each { |name| possible_names << filename[name] if filename[name]}

      possible_names.each do |name|
        found_names = Instructor.where("lower(name) LIKE ?", "%#{name.downcase}%")
        results[:instructor] = found_names.first if found_names.count == 1
      end


      # determine term
      term_regex = /[(fall|fa|f|spring|sp|s)]+/i
      year_regex = /((\d){2,4})/i

      regex = /[(fall|fa|f|spring|sp|s)]+[\s+_-]*?[\d]{2,4}/i

      filename.scan(regex).each do |pattern|
        unless pattern.split(term_regex)[1].blank?
          term = pattern.match(term_regex).to_s.downcase.titleize
          term = 'Fall' if term == 'F' || term == 'Fa'
          term = 'Spring' if term == 'S' || term == 'Sp'

          year = pattern.strip.match(year_regex).to_s
          year = '20' + year if year.size == 2

          results[:term] = term.downcase.titleize + ' ' + year if term && year.to_i.to_s == year
        end
      end
      
      return results
    end
end
