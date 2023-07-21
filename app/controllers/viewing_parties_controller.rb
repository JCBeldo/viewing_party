class ViewingPartiesController < ApplicationController
  def new
    if session[:user_id]
      @user = User.find(session[:user_id])
      @users = User.all
      @movie = params[:movie_id]
      @details = TmdbFacade.new.movie_details(@movie)
    else
      flash[:alert] = 'Please sign in or register'
      redirect_to root_path
    end
  end

  def create
    user = User.find(params[:user_id])
    movie = params[:movie]
    if params[:duration].to_i < params[:movie_duration].to_i
      redirect_to "/movies/#{movie}/viewing-party/new"
      flash[:alert] = 'Party Duration is Less Than Movie Duration'
    else
      viewing_party = ViewingParty.new(viewing_party_params)
      if viewing_party.save
        params.each do |key, value|
          if key.to_i != 0 && value == "1"
            ViewingPartyUser.create!(viewing_party_id: viewing_party.id, user_id: key)
          end
        end
        redirect_to "/users/#{user.id}"
      end
    end
  end

  private

  def viewing_party_params
    params.permit(:duration, :start_date, :start_time, :user_id, :movie)
  end
end
