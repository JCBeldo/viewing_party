class TmdbFacade
  def movie_search(search)
    MovieSearch.new(service.search_url(search))
  end

  def top_rated_list
    TopRated.new(service.top_movies_url)
  end

  def movie_details(movie_id)
    Details.new(service.details_url(movie_id))
  end

  def movie_reviews(movie_id)
    Reviews.new(service.reviews_url(movie_id))
  end

  def service
    TmdbService.new
  end

  def movie_actors(movie_id)
    Actors.new(service.cast_url(movie_id))
  end
end
