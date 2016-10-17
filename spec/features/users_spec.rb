require 'rails_helper'

feature 'User create' do

  scenario "add a new user" do
    visit new_user_registration_path
    expect{
    fill_in 'user_name', with: 'taketani'
    fill_in 'user_email', with: 'ccc@ccc'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    fill_in 'user_group', with: 'grouptest'
    fill_in 'user_profile', with: 'profiletest'
    fill_in 'user_works', with: 'worktest'
    click_on 'save'
    }.to change(User, :count).by(1)
    expect(page).to have_content ' Welcome! You have signed up successfully'
  end

end
