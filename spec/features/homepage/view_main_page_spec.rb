require 'rails_helper'

feature 'User views the homepage', %{
  As a user
  I want to see the landing page for the app
  So that I can learn more and create an account
} do
  # ACCEPTANCE CRITERIA
  # [X] An unauthenticated user sees the main homepage with links to sign in
  # [X] An authenticated user gets redirected to the main advisees page

  scenario 'an unauthenticated user visits the main page' do
    visit root_path

    expect(page).to have_content('Advising Assistant')
    expect(page).to have_link('Sign Up')
    expect(page).to have_link('Sign In')
  end

  scenario 'an authenticated user sees their advisees' do
    user = FactoryGirl.create(:user)
    advisee = FactoryGirl.create(:advisee, user: user)
    sign_in user

    visit root_path

    expect(page).to have_content('Advisees')
    expect(page).to have_content(advisee.full_name)
  end
end
