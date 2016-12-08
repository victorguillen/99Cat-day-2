class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    u = User.find_by_cred(session_params[:username], session_params[:password])
    if u
      self.login_user(u)
      redirect_to user_url(u)
    else
      flash.now[:messages] = u.errors.full_messages
      render :new
    end
  end

  def destroy
    if current_user
      logout!
    end
    redirect_to new_sessions_url
  end

  private
    def session_params
      params.require(:session).permit(:username, :password)
    end
end
