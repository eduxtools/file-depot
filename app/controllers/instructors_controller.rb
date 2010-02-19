class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.find(:all, :order => 'name ASC',  :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end

end
