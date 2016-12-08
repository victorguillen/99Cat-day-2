class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def show
    if self.current_user
      @user = self.current_user
      render :show
    else
      redirect_to new_user_url
    end
  end

  def new
    render :new
  end

  def create
    name = user_params[:username]
    password = user_params[:password]
    u = User.new(username: name, password: password)
    if u.save
      self.login_user(u)
      redirect_to user_url(u)
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :pw_digest, :session_token)
    end
end
