class MoviesController < ApplicationController
  def index
    if params[:search_field]
      @results = TmdbFacade.new.movie_search(params[:search_field]).search_results
    else
      @results = TmdbFacade.new.top_rated_list.top_rated_movies
    end
  end

  def show
    @movie = params[:movie_id]
    @actors = TmdbFacade.new.movie_actors(@movie).actors
    @reviews = TmdbFacade.new.movie_reviews(@movie)
    @details = TmdbFacade.new.movie_details(@movie)
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def discover; end
end
