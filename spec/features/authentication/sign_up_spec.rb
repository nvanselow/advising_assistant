require 'rails_helper'

feature 'Sign up for an account', %{
  As an unauthenticated user
  I want to enter my information to sign up for a new account
  So that I can gain access to the system
} do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to create an account if I am not signed in
  # [X] I must specify a valid email address
  # [X] I must specify a valid password and password confirmation
  # [X] I must specify a first name
  # [X] I must specify a last name
  # [X] If I complete the form successfully, I am logged in to the system
  # [X] If I complete the form successfuly, I see a success message
  # [X] If I complete the form incorrectly, I see an error message indicating
  #     what I need to fix

  context 'user is authenticated' do
    before do
      user = FactoryGirl.create(:user)
      sign_in user
    end

    scenario 'authenticated user cannot see the sign up link' do
      visit root_path

      within('nav') do
        expect(page).not_to have_link('Sign Up')
      end
    end
  end

  context 'user is not authenticated' do
    let(:user) { FactoryGirl.attributes_for(:user) }

    scenario 'unauthenticated user can see the sign up link' do
      visit root_path

      within('#nav-links') do
        expect(page).to have_link('Sign Up')
      end
    end

    scenario 'user signs up for an account correctly' do
      visit root_path

      within('#nav-links') do
        click_link('Sign Up')
      end
      fill_in('Email', with: user[:email])
      fill_in('First Name', with: user[:first_name])
      fill_in('Last Name', with: user[:last_name])
      fill_in('Password', with: user[:password])
      fill_in('Password Confirmation', with: user[:password])
      within('.actions') do
        click_button('Sign Up')
      end

      within('nav') do
        expect(page).to have_content(user[:email])
      end
    end

    context 'user is on sign up form' do
      before do
        visit new_user_registration_path
      end

      scenario 'user forgets to add an email' do
        fill_in('First Name', with: user[:first_name])
        fill_in('Last Name', with: user[:last_name])
        fill_in('Password', with: user[:password])
        fill_in('Password Confirmation', with: user[:password])
        click_button('Sign Up')

        expect(page).to have_content('There was a problem creating your '\
                                     'account')
        expect(page).to have_content("Email can't be blank")
        expect_not_signed_in
      end

      scenario 'user does not provide a password' do
        fill_in('Email', with: user[:email])
        fill_in('First Name', with: user[:first_name])
        fill_in('Last Name', with: user[:last_name])
        fill_in('Password Confirmation', with: user[:password])
        click_button('Sign Up')

        expect(page).to have_content('There were 2 errors creating your '\
                                     'account')
        expect(page).to have_content("Password can't be blank")
        expect_not_signed_in
      end

      scenario 'password confirmation does not match' do
        fill_in('Email', with: user[:email])
        fill_in('First Name', with: user[:first_name])
        fill_in('Last Name', with: user[:last_name])
        fill_in('Password', with: user[:password])
        fill_in('Password Confirmation', with: 'something not matching')
        click_button('Sign Up')

        expect(page).to have_content('There was a problem creating your '\
                                     'account')
        expect(page).to have_content("Password confirmation doesn't match")
        expect_not_signed_in
      end

      scenario 'user does not enter their name' do
        fill_in('Email', with: user[:email])
        fill_in('Password', with: user[:password])
        fill_in('Password Confirmation', with: user[:password])
        click_button('Sign Up')

        expect(page).to have_content('There were 2 errors creating your '\
                                     'account')
        expect(page).to have_content("First name can't be blank")
        expect(page).to have_content("Last name can't be blank")
      end

      scenario 'user sees success message' do
        fill_in('Email', with: user[:email])
        fill_in('First Name', with: user[:first_name])
        fill_in('Last Name', with: user[:last_name])
        fill_in('Password', with: user[:password])
        fill_in('Password Confirmation', with: user[:password])
        click_button('Sign Up')

        expect(page).to have_content('You have signed up successfully')
      end
    end
  end
end

def expect_not_signed_in
  within('nav') do
    expect(page).not_to have_content(user[:email])
  end
end
