class Browse::WorksController < ApplicationController
  layout 'browse'
  before_filter :load_works
  before_filter :set_use_remote
  
  def index
  end

  def show
    @work = Work.find(params[:id])
  end

  private
    def set_use_remote
      @use_remote = true
    end

    def load_works
      if params[:project]
        params[:course] = Project.find(params[:project]).try(:course).try(:id)
      end

      if params[:course]
        params[:level] = Course.find(params[:course]).try(:level)
      end

      conditions = {}
      conditions.merge!({instructor_id: params[:instructor]})                  unless params[:instructor].blank?
      conditions.merge!({project_id: params[:project]})                        unless params[:project].blank?
      conditions.merge!({course_id: params[:course]})                          unless params[:course].blank?
      conditions.merge!({course_id: Course.where(level: params[:level]).ids})  unless params[:level].blank?

      unless conditions.blank?
        @works = Work.where(conditions)
      end
    end
end
