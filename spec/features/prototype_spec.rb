require 'rails_helper'
require 'pry-rails'

feature 'Prototype create' do
  given(:user) { FactoryGirl.build(:user)}
  background do
    user.save
  end
  scenario "sign-in and post prototype" do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Sign in'
      expect(page).to have_content ' Signed in successfully'
      click_on 'New Proto'
      expect{
        fill_in 'prototype_title', with: 'title-test'
        attach_file 'prototype_images_attributes_0_photo', "spec/files/img/m1.png"
        attach_file 'prototype_images_attributes_0_photo', "spec/files/img/s1.png"
        attach_file 'prototype_images_attributes_0_photo', "spec/files/img/s2.png"
        attach_file 'prototype_images_attributes_0_photo', "spec/files/img/s3.png"
        fill_in 'prototype_catchcopy', with: 'catchcopy-test'
        fill_in 'prototype_concept',   with: 'concept-test'
        fill_in 'Web Design',   with: 'Tag1-test'
        fill_in 'UI',           with: 'Tag2-test'
        fill_in 'Applicaiton',  with: 'Tag3-test'
        click_on 'Publish'}.to change(Prototype, :count).by(1)
        expect(page).to have_content 'Your prototype is posted'
  end
end
