class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @hosted_parties = ViewingParty.where(:user_id == @user.id)
    @details = TmdbFacade.new
  end

  def new; end

  def discover
    @user = User.find(params[:id])
  end

  def create
    user = user_params
    user[:password] = user[:password].downcase
    new_user = User.new(user)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{user_params[:name]}!"
      redirect_to user_path(new_user)
    else
      flash[:error] = 'Email is not unique or form is not fully complete or passwords do not match'
      redirect_to register_path
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
