require 'rails_helper'

RSpec.describe TmdbFacade do
  describe 'creates TMDB Facade' do
    it 'has a movie search facade with attributes', :vcr do
      movie = TmdbFacade.new.movie_search('The Godfather')

      expect(movie.search_results.first[:title]).to eq('The Godfather')
    end
    
    it 'has a top rated list facade with attributes', :vcr do
      movie = TmdbFacade.new.top_rated_list
      
      expect(movie.top_rated_movies.first[:title]).to eq('The Godfather')
      expect(movie.top_rated_movies.last[:title]).to eq("Gabriel's Inferno")
    end
    
    it 'has a movie details facade with attributes', :vcr do
      movie = TmdbFacade.new.movie_details('238')
  
      expect(movie.title).to eq('The Godfather')
      expect(movie.runtime).to eq('2h 55m')
      expect(movie.vote_average).to eq(8.71)
    end
    
    it 'has a movie reviews facade with attributes', :vcr do
      movie = TmdbFacade.new.movie_reviews('238')
  
      expect(movie.reviews.first[:author]).to eq('futuretv')
      expect(movie.results).to eq(5)
    end
    
    it 'has a movie actors facade with attributes', :vcr do
      movie = TmdbFacade.new.movie_actors('238')
  
      expect(movie.actors).to be_a Array
      expect(movie.actors.count).to eq(10)
    end
  end
end