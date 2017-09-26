class SessionsController < ApplicationController
  skip_before_action :login_required

  layout 'sessions'

  def new
  end

  def create
    user = User.find_by(login: params[:login])
    user ||= User.find_by(email: params[:login])

    if user && user.authenticate(params[:password])
      # login method
      login(user)

      # redirect path
      redirect_path = session[:redirect_after_login] || root_url
      session[:redirect_after_login] = nil

      redirect_to redirect_path, notice: 'Login Successful!'

    else
      # wrong email/password
      flash[:notice] = 'Login incorrect'
      render :new
    end
  end

  # logout
  def destroy
    logout()
    redirect_to root_url
  end
end
