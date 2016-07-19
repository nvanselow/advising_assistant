require 'rails_helper'

feature 'User can sign out', %{
  As an authenticated user
  I want to sign out
  So that I can make sure other people using the computer cannot access my information
} do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to sign out if I am authenticated
  # [X] Clicking that option signs me out of the system and I am not longer authenticated
  # [X] An option to sign back in is available
  # [X] I see a message that I am signed out

  context 'User is already authenticated' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit root_path
    end

    scenario 'Sign out button is available for authenticated user' do
      within('nav') do
        expect(page).to have_link('Sign Out')
        expect(page).not_to have_link('Sign In')
      end
    end

    scenario 'Sign out of app' do
      click_link('Sign Out')

      expect(page).to have_content('Signed out successfully')
      within('nav') do
        expect(page).not_to have_content(user.email)
        expect(page).not_to have_link('Sign Out')
        expect(page).to have_link('Sign In')
      end
    end
  end
end
