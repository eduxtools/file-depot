class Browse::SubmissionsController < ApplicationController
  before_action :login_required

  layout 'browse'
  before_filter :load_nav_objects
  before_filter :load_submissions
  before_filter :set_use_remote

  def index
  end

  def show
    # @work = Work.find(params[:id])
    @submission = Submission.find(params[:id])
  end

  private
    def set_use_remote
      @use_remote = false
    end

    def load_nav_objects
      @categories     = ['Painting', 'Sculpture', 'Computer Graphic', 'Drawing', 'Photograph', "Ceramic", 'Video/DVD Production', 'Printmaking', 'Mixed Media']
      @grades         = [6, 7, 8, 9, 10, 11, 12]
      # @areas        = Course.areas
      # @courses      = Course.where(has_works: true).order('number ASC')
      # @instructors  = Instructor.where(has_works: true).order('name ASC')
      # @levels       = ['Freshman', 'Sophomore', 'Junior', 'Senior']
    end

    def load_submissions
      @submissions = Submission.all

      if !params[:grade].blank?
        @submissions = @submissions.where("data like ?", "%Grade: #{params[:grade].to_i}%")
      end

      if !params[:category].blank?
        # To sanatize, make sure category param is in list of options
        category = (@categories & [params[:category]])[0]
        if category
          @submissions = @submissions.where("data like ? OR data like ?", "%Entry 1 Category: #{category}%", "%Entry 2 Category: #{category}%")
        end
      end


    end

    def load_works
      # if !params[:project].nil?
      #   @project        = Project.find_by_id(params[:project])
      #   params[:course] = @project.try(:course).try(:id)
      # end
      #
      # if !params[:instructor].nil?
      #   @instructor     = Instructor.find_by_id(params[:instructor])
      # end
      #
      # if !params[:course].nil?
      #   @course         = Course.find_by_id(params[:course])
      #   # params[:level] = Course.find_by_id(params[:course]).try(:level)
      # end
      #
      # if !params[:course].blank?
      #   # just select course
      #   course_ids = params[:course]
      #
      # elsif !params[:level].blank? && !params[:area].blank?
      #   # combine course ids
      #   course_ids = Course.where(level: params[:level]).ids & Course.where(area: params[:area]).ids
      #
      # elsif !params[:level].blank?
      #   # select just level courses
      #   course_ids = Course.where(level: params[:level]).ids
      #
      # elsif !params[:area].blank?
      #   # select just area courses
      #   course_ids = Course.where(area: params[:area]).ids
      #
      # else
      #   # ignore course ids
      #   course_ids = nil
      # end
      #
      # conditions = {}
      # conditions.merge!({instructor_id: params[:instructor]})                  unless params[:instructor].blank?
      # conditions.merge!({project_id: params[:project]})                        unless params[:project].blank?
      # conditions.merge!({course_id: course_ids})                               unless course_ids.blank?
      #
      # conditions.merge!({has_images: true})                                    if params[:only_images] == 't'
      #
      # unless conditions.blank?
      #   @works = Work.where({has_attachments: true}.merge(conditions)).order('created_at DESC').includes(:instructor, :course, :project)
      # end
    end
end
