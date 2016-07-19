require 'rails_helper'

feature 'User can sign in', %{
  As an unauthenticated user
  I want to sign in
  So I can access the system
} do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to sign in if I am not authenticated
  # [X] I must specify a valid email address
  # [X] I must enter my password
  # [X] If I've entered the correct credentials, I see a success message and I
  #     can gain access to the system
  # [X] If I didn't enter the correct credentials, I see an error message,
  #     and I am not signed in
  # [X] If I am already authenticated, I do not see an option to sign in

  scenario 'Sign in option is available when not authenticated' do
    visit root_path

    within('nav') do
      expect(page).to have_link('Sign In')
    end
  end

  scenario 'User cannot see sign in if already authenticated' do
    user = FactoryGirl.create(:user)
    sign_in user

    visit root_path

    within('nav') do
      expect(page).not_to have_link('Sign In')
    end
  end

  context 'User is on sign in form' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      visit new_user_session_path
    end

    scenario 'User signs in correctly' do
      fill_in('Email', with: user.email)
      fill_in('Password', with: user.password)
      click_button('Sign In')

      within('nav') do
        expect(page).to have_content(user.email)
      end
    end

    scenario 'User sees success message if signed in correctly' do
      fill_in('Email', with: user.email)
      fill_in('Password', with: user.password)
      click_button('Sign In')

      expect(page).to have_content('Signed in successfully')
    end

    scenario 'User does not enter a valid email address' do
      fill_in('Email', with: '')
      fill_in('Password', with: user.password)
      click_button('Sign In')

      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'User does not enter a password' do
      fill_in('Email', with: user.email)
      fill_in('Password', with: '')
      click_button('Sign In')

      expect(page).to have_content('Invalid Email or password')
    end

    scenario 'User enters incorrect password (bad credentials)' do
      fill_in('Email', with: user.email)
      fill_in('Password', with: 'This is the wrong password')
      click_button('Sign In')

      expect(page).to have_content('Invalid Email or password')
    end
  end
end
