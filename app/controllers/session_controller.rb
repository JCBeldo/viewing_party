class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash[:error] = 'Invalid Credentials'
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
