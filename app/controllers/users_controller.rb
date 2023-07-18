class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @hosted_parties = ViewingParty.where(:user_id == @user.id)
    @details = TmdbFacade.new
  end

  def new
  end

  def discover
    @user = User.find(params[:id])
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      flash[:success] = "Welcome, #{user_params[:name]}!"
      redirect_to user_path(new_user)
    else
      redirect_to register_path
      flash[:alert] = 'Email is not unique or form is not fully complete'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
