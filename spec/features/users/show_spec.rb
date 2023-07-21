require 'rails_helper'

RSpec.describe 'Users Dashboard' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }

  let!(:vp1) { create(:viewing_party, user_id: user1.id, movie: 1864) }
  let!(:vp2) { create(:viewing_party, user_id: user1.id, movie: 1999) }
  let!(:vp3) { create(:viewing_party, user_id: user2.id, movie: 1985) }

  describe 'Displays page content' do
    it 'should display the name of the dashboard and list of viewing parties' do
      VCR.use_cassette('spec/fixtures/vcr_cassettes/user_dashboard/user_dashboard_contents.yml') do
        VCR.use_cassette('spec/fixtures/vcr_cassettes/user_dashboard/image.yml') do
          vpu1 = ViewingPartyUser.create(user_id: user2.id, viewing_party_id: vp1.id)
          vpu2 = ViewingPartyUser.create(user_id: user3.id, viewing_party_id: vp1.id)

          vpu3 = ViewingPartyUser.create(user_id: user2.id, viewing_party_id: vp2.id)
          vpu_4 = ViewingPartyUser.create(user_id: user3.id, viewing_party_id: vp2.id)

          vpu_5 = ViewingPartyUser.create(user_id: user1.id, viewing_party_id: vp3.id)
          vpu_6 = ViewingPartyUser.create(user_id: user3.id, viewing_party_id: vp3.id)

          visit user_path(user1)

          expect(page).to have_content("#{user1.name}'s Dashboard")
          expect(page).to have_button('Discover Movies')
          expect(page).to have_link('Hello-Goodbye')
          expect(page).to have_link('In the Bedroom')
          expect(page).to have_link('The Constant Gardener')
          expect(page).to have_content(vp1.start_date)
          expect(page).to have_content(vp2.start_date)
          expect(page).to have_content(vp3.start_date)
          expect(page).to have_content(vp1.start_time.strftime('%I:%M%p'))
          expect(page).to have_content(vp2.start_time.strftime('%I:%M%p'))
          expect(page).to have_content(vp3.start_time.strftime('%I:%M%p'))

          expect(page).to have_content("Host: #{user1.name}")
          expect(page).to have_content("#{user2.name}")
          expect(page).to have_content("#{user3.name}")

          expect(page).to have_content("Host: #{user2.name}")
          expect(page).to have_content("#{user1.name}")
        end
      end
    end
  end

  describe 'Verifies links' do
    it 'discover movie button directs you to /users/:id/discover', :vcr do
      VCR.use_cassette('spec/fixtures/vcr_cassettes/user_dashboard/user_dashboard_contents.yml') do
        VCR.use_cassette('spec/fixtures/vcr_cassettes/user_dashboard/image.yml') do
          visit user_path(user1)

          click_button('Discover Movies')
          expect(current_path).to eq('/discover')
        end
      end
    end
  end
end
