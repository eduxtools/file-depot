class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.find(:all, :order => 'name ASC',  :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end

  def show
    @instructor = Instructor.find(params[:id]) # Eager loading must not be used, as a rails bug(?) does not allow :uniq to work with eager loading 
  end
end
