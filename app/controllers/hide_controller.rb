class HideController < ApplicationController
  
  def none
    session[:hide] = false
    redirect_to works_path
  end
  
  def all
    session[:hide] = true
    redirect_to works_path
  end
  
end
