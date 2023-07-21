require 'rails_helper'

RSpec.describe 'New Viewing Party Page' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }

  let!(:vp1) { create(:viewing_party, user_id: user1.id, movie: 1864) }
  let!(:vp2) { create(:viewing_party, user_id: user1.id, movie: 1999) }
  let!(:vp3) { create(:viewing_party, user_id: user1.id, movie: 1985) }

  describe 'displays viewing party attributes' do
    it 'should display the title of the movie and a form to make a new viewing party', :vcr do
      visit login_path

      fill_in(:email, with: "#{user1.email}")
      fill_in(:password, with: "#{user1.password}")
      click_button('Log In')

      visit '/movies/238/viewing-party/new'

      expect(page).to have_content('The Godfather')
      expect(page).to have_content('Duration of Party')
      expect(page).to have_content('Day')
      expect(page).to have_content('Start Time')
      expect(page).to have_unchecked_field
      expect(page).to have_content(user2.name)
      expect(page).to have_button('Create Party')
    end

    it 'will redirect to the user dashboard after form is filled and submitted' do
      VCR.use_cassette('spec/fixtures/vcr_cassettes/new_viewing_party/new_viewing_party_contents.yml') do
        VCR.use_cassette('spec/fixtures/vcr_cassettes/new_viewing_party/idk.yml') do
          visit login_path

          fill_in(:email, with: "#{user1.email}")
          fill_in(:password, with: "#{user1.password}")
          click_button('Log In')

          visit '/movies/238/viewing-party/new'

          fill_in(:duration, with: '200')
          click_button('Create Party')

          expect(current_path).to eq(user_path(user1))
        end
      end
    end

    it 'flashes a message when party duration is less than movie duration', :vcr do
      visit login_path

      fill_in(:email, with: "#{user1.email}")
      fill_in(:password, with: "#{user1.password}")
      click_button('Log In')

      visit '/movies/238/viewing-party/new'

      fill_in(:duration, with: '150')
      click_button('Create Party')

      expect(current_path).to eq('/movies/238/viewing-party/new')
      expect(page).to have_content('Party Duration is Less Than Movie Duration')
    end
  end
end
