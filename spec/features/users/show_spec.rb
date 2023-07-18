require 'rails_helper'

RSpec.describe 'Users Dashboard' do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:user_3) { create(:user) }

  let!(:vp_1) { create(:viewing_party, user_id: user_1.id, movie: 1864) }
  let!(:vp_2) { create(:viewing_party, user_id: user_1.id, movie: 1999) }
  let!(:vp_3) { create(:viewing_party, user_id: user_2.id, movie: 1985) }

  describe 'Displays page content' do
    it 'should display the name of the dashboard and list of viewing parties' do
      VCR.use_cassette('spec/fixtures/vcr_cassettes/user_dashboard/user_dashboard_contents.yml') do
        VCR.use_cassette('spec/fixtures/vcr_cassettes/user_dashboard/image.yml') do
          vpu_1 = ViewingPartyUser.create(user_id: user_2.id, viewing_party_id: vp_1.id)
          vpu_2 = ViewingPartyUser.create(user_id: user_3.id, viewing_party_id: vp_1.id)

          vpu_3 = ViewingPartyUser.create(user_id: user_2.id, viewing_party_id: vp_2.id)
          vpu_4 = ViewingPartyUser.create(user_id: user_3.id, viewing_party_id: vp_2.id)

          vpu_5 = ViewingPartyUser.create(user_id: user_1.id, viewing_party_id: vp_3.id)
          vpu_6 = ViewingPartyUser.create(user_id: user_3.id, viewing_party_id: vp_3.id)

          visit user_path(user_1)
          
          expect(page).to have_content("#{user_1.name}'s Dashboard")
          expect(page).to have_button('Discover Movies')
          expect(page).to have_link('Hello-Goodbye')
          expect(page).to have_link('In the Bedroom')
          expect(page).to have_link('The Constant Gardener')
          expect(page).to have_content(vp_1.start_date)
          expect(page).to have_content(vp_2.start_date)
          expect(page).to have_content(vp_3.start_date)
          expect(page).to have_content(vp_1.start_time.strftime("%I:%M%p"))
          expect(page).to have_content(vp_2.start_time.strftime("%I:%M%p"))
          expect(page).to have_content(vp_3.start_time.strftime("%I:%M%p"))

          expect(page).to have_content("Host: #{user_1.name}")
          expect(page).to have_content("#{user_2.name}")
          expect(page).to have_content("#{user_3.name}")

          expect(page).to have_content("Host: #{user_2.name}")
          expect(page).to have_content("#{user_1.name}")
        end
      end
    end
  end

  describe 'Verifies links' do
    it 'discover movie button directs you to /users/:id/discover', :vcr do
      VCR.use_cassette('spec/fixtures/vcr_cassettes/user_dashboard/user_dashboard_contents.yml') do
        VCR.use_cassette('spec/fixtures/vcr_cassettes/user_dashboard/image.yml') do
          visit user_path(user_1)

          click_button('Discover Movies')
          expect(current_path).to eq("/users/#{user_1.id}/discover")
        end
      end
    end
  end
end
