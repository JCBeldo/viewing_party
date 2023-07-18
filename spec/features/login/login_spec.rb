require 'rails_helper'

RSpec.describe 'Logging In' do
  it 'can log in with valid credentials' do
    user = User.create(email: 'funbucket13@gmail.com', password: 'test', name: 'Billy')

    visit root_path

    click_on 'I already have an account'

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it 'cannot login with bad credentials' do
    user = User.create!(email: 'funbucket13', password: 'test', name: 'Billy')

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: 'bad pword'

    click_on 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Invalid Credentials')
  end
end
