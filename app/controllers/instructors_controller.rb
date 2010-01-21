class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end

end
