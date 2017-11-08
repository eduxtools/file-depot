class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #

  helper_method :current_user, :logged_in?, :login, :logout
  before_action :login_required, except: [:index, :download_pdf]

  def index
    # application 'start page'
    # MTRSAE specific
    render layout: 'sessions'
  end

  # MTRSAE specific
  def download_pdf
    send_file(
      "#{Rails.root}/public/MTRSAE-prospectus-2017.pdf",
      filename: "MTRSAE-prospectus-2017.pdf",
      type: "application/pdf"
    )
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

    # NOTE Not automatically called, must be added to applicable controllers
    def prevent_reviewer_access
      if current_user.try(:name).to_s.downcase.include?('reviewer')
        redirect_to browse_submissions_path()
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
