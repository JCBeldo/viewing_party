require 'rails_helper'

RSpec.describe 'movie discover page' do
  describe 'movie discover page content/links' do
    it 'displays movie discover page content' do
      visit '/discover'

      expect(page).to have_button('Discover Top Rated Movies')
      expect(page).to have_field(:search_field)
      expect(page).to have_button('Search')
    end
  end

  describe 'verifies funcitonality of links' do
    it 'button to top rated movies works', :vcr do
      visit '/discover'

      click_button('Discover Top Rated Movies')
      expect(current_path).to eq('/movies')
    end

    it 'search button works', :vcr do
      visit '/discover'

      fill_in(:search_field, with: 'Transformers')
      click_button('Search')
      expect(current_path).to eq('/movies')
    end
  end
end
