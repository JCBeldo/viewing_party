require 'rails_helper'

RSpec.describe 'new user page' do 
  describe 'create a new user form' do
    it 'verifies the functionality of the form' do
      visit register_path

      fill_in(:name, with: 'Austin')
      fill_in(:email, with: 'austin@gmail.com')
      fill_in(:password, with: 'test')
      fill_in(:password_confirmation, with: 'test')
      click_button('Register')

      user = User.all.last

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('test')
      expect(current_path).to eq(user_path(user))
    end

    it 'verifies the functionality of password confirmation' do
      visit register_path

      fill_in(:name, with: 'Austin')
      fill_in(:email, with: 'austin@gmail.com')
      fill_in(:password, with: 'test')
      fill_in(:password_confirmation, with: 'not a test')

      click_button('Register')

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email is not unique or form is not fully complete or passwords do not match')
    end

    it 'verifies the sad path of the form' do
      visit register_path

      fill_in(:name, with: '')
      fill_in(:email, with: 'austin@gmail.com')
      fill_in(:password, with: 'test')
      fill_in(:password_confirmation, with: 'test')

      click_button('Register')

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email is not unique or form is not fully complete or passwords do not match')
    end
  end
end
