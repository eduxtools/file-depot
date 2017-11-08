class Browse::WorksController < ApplicationController
  before_action :login_required
  before_action :prevent_reviewer_access

  layout 'browse'
  before_filter :load_works
  before_filter :set_use_remote
  before_filter :load_nav_objects

  def index
  end

  def show
    @work = Work.find(params[:id])
  end

  private
    def set_use_remote
      @use_remote = true
    end

    def load_nav_objects
      @areas        = Course.areas
      @courses      = Course.where(has_works: true).order('number ASC')
      @instructors  = Instructor.where(has_works: true).order('name ASC')
    end

    def load_works
      if !params[:project].nil?
        @project        = Project.find_by_id(params[:project])
        params[:course] = @project.try(:course).try(:id)
      end

      if !params[:instructor].nil?
        @instructor     = Instructor.find_by_id(params[:instructor])
      end

      if !params[:course].nil?
        @course         = Course.find_by_id(params[:course])
        # params[:level] = Course.find_by_id(params[:course]).try(:level)
      end

      if !params[:course].blank?
        # just select course
        course_ids = params[:course]

      elsif !params[:level].blank? && !params[:area].blank?
        # combine course ids
        course_ids = Course.where(level: params[:level]).ids & Course.where(area: params[:area]).ids

      elsif !params[:level].blank?
        # select just level courses
        course_ids = Course.where(level: params[:level]).ids

      elsif !params[:area].blank?
        # select just area courses
        course_ids = Course.where(area: params[:area]).ids

      else
        # ignore course ids
        course_ids = nil
      end

      conditions = {}
      conditions.merge!({instructor_id: params[:instructor]})                  unless params[:instructor].blank?
      conditions.merge!({project_id: params[:project]})                        unless params[:project].blank?
      conditions.merge!({course_id: course_ids})                               unless course_ids.blank?

      conditions.merge!({has_images: true})                                    if params[:only_images] == 't'

      unless conditions.blank?
        @works = Work.where({has_attachments: true}.merge(conditions)).order('created_at DESC').includes(:instructor, :course, :project)
      end
    end
end
