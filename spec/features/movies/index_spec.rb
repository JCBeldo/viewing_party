require 'rails_helper'

RSpec.describe 'Discover Movies Page', type: :feature do
  describe 'displays search results of discovery with title and vote average of 20max movies' do
    it 'should display the movie results title and scores of top movies', :vcr do
      visit '/discover'

      click_button('Discover Top Rated Movies')
      expect(current_path).to eq('/movies')
      expect(page).to have_content('The Godfather')
      expect(page).to have_content('Rating: 8.7')
      expect(page).to have_content('The Shawshank Redemption')
      expect(page).to have_content('Rating: 8.7')
    end

    it 'should display the movie results title plus scores of searched movies', :vcr do
      visit '/discover'

      fill_in(:search_field, with: 'transformers')
      click_button('Search')
      expect(current_path).to eq('/movies')
      expect(page).to have_content('Title: Transformers')
      expect(page).to have_content('Rating: 6.776')
    end

    it 'should display each title as a link', :vcr do
      visit '/movies'

      click_link('The Godfather')
      expect(current_path).to eq('/movies/238')
    end
  end
end
