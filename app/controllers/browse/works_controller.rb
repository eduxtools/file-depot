class Browse::WorksController < ApplicationController
  layout 'browse'
  before_filter :load_works
  
  def index
  end

  def show
    @work = Work.find(params[:id])
  end

  private
    def load_works
      conditions = {}
      conditions.merge!({instructor_id: params[:instructor]})                  unless params[:instructor].blank?
      conditions.merge!({course_id: params[:course]})                          unless params[:course].blank?
      conditions.merge!({course_id: Course.where(level: params[:level]).ids})  unless params[:level].blank?

      unless conditions.blank?
        @works = Work.where(conditions)
      end

      # temp
      @works ||= Work.all
    end
end
