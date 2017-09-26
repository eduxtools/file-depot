class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #

  helper_method :current_user, :logged_in?, :login, :logout
  before_action :login_required

  def index
    # application 'start page'
  end

  private
    def current_user
      return User.find_by_id(session[:user_id])
    end

    def logged_in?
      return !current_user.nil?
    end

    def login_required
      unless logged_in?
        set_session_redirect_after_login
        return redirect_to login_url, notice: 'You must login to continue'
      end
    end

    def login(user)
      session[:user_id] = user.id
    end

    def logout
      session[:user_id] = nil
    end

    def set_session_redirect_after_login
      session[:redirect_after_login] = "#{request.fullpath}" if request.format && request.format.html?
    end
end
