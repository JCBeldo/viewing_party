require 'rails_helper'

RSpec.describe 'root' do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:user_3) { create(:user) }

  describe 'welcome page' do
    it 'verifies content' do
      visit root_path

      expect(page).to have_content('Viewing Party')
      expect(page).to have_button('Create New User')
      expect(page).to have_link(user_1.name)
      expect(page).to have_link(user_2.name)
      expect(page).to have_link(user_3.name)
      expect(page).to have_link('Home')
    end
  end
  describe 'links' do
    it 'verifies functionality of user dashboard link' do
      visit root_path

      click_link(user_1.name)
      expect(current_path).to eq(user_path(user_1))
    end

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
