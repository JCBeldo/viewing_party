require 'rails_helper'

RSpec.describe 'root' do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }

  describe 'welcome page' do
    it 'verifies content' do
      visit login_path

      fill_in(:email, with: "#{user1.email}")
      fill_in(:password, with: "#{user1.password}")
      click_button('Log In')

      expect(page).to have_content('Viewing Party')
      expect(page).to_not have_button('Create New User')
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
      expect(page).to have_content(user3.email)
      expect(page).to have_link('Home')
      expect(page).to have_link('Log Out')
    end

    it 'displays only links to login or create a new user if not logged in' do
      visit root_path

      expect(page).to have_content('Create New User')
      expect(page).to have_content('I already have an account')
      expect(page).to_not have_content('Existing Users')
      expect(page).to_not have_link('Log Out')
      expect(page).to_not have_link(user1.name)
    end

    it 'cannot visit /dashboard while signed out' do
      visit '/dashboard'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Please sign in or register first')
    end

    it 'can visit /dashboard while signed in' do
      visit login_path

      fill_in(:email, with: "#{user1.email}")
      fill_in(:password, with: "#{user1.password}")
      click_button('Log In')

      visit '/dashboard'

      expect(current_path).to eq(user_path(user1))
      expect(current_path).to_not eq(user_path(user2))
    end
  end

  describe 'links' do
    it 'verifies functionality of home page link' do
      visit root_path

      click_link('Home')
      expect(current_path).to eq(root_path)
    end

    it 'verifies functionality of Create New User button' do
      visit root_path

      click_button('Create New User')
      expect(current_path).to eq(register_path)
    end

    it 'verifies functionality of Login link' do
      visit root_path

      click_link('I already have an account')
      expect(current_path).to eq(login_path)
    end
  end
end
