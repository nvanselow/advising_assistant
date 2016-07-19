require 'rails_helper'

feature 'Create a new advisee', %{
  As an advisor
  I want to create a new advisee
  So that I can start tracking information about that advisee
} do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to create a new advisee
  # [X] I can fill out a form with first name, last name, email address,
  #     graduation semester, and graduation year for the advisee
  # [X] If I fill out the form successfully, I get a success message and I am
  #     brought to the specific page for that advisee
  # [X] If I fill out the form incorrectly, I get an error message related
  #     noting parts of the form I need to fix
  # [X] An unauthenticated user cannot create advisees

  scenario 'unauthenticated user attempts to create an advisee' do
    visit new_advisee_path

    expect(page).to have_content('You need to sign in or sign up before '\
                                 'continuing')
  end

  context 'user is authenticated' do
    let(:user) { FactoryGirl.create(:user) }
    let(:advisee) { FactoryGirl.attributes_for(:advisee) }

    before do
      sign_in user
    end

    scenario 'user navigates to new advisee form from advisees list' do
      visit advisees_path

      click_link('Add Advisee')

      expect(page).to have_content('Add an Advisee')
      expect(page).to have_css('form')
    end

    context 'user is on the new advisees form' do
      before do
        visit new_advisee_path
      end

      scenario 'user fill out the new advisee form correctly' do
        fill_in('First Name', with: advisee[:first_name])
        fill_in('Last Name', with: advisee[:last_name])
        fill_in('Email', with: advisee[:email])
        select(advisee[:graduation_semester], from: 'Graduation Semester')
        fill_in('Graduation Year', with: advisee[:graduation_year])

        click_button('Save Advisee')

        expect(page).to have_content('Advisee added successfully')
        expect(page).to have_content(advisee[:full_name])
        expect(page).to have_content(advisee[:email])
        expect(page).to have_content(advisee[:graduation_semester])
        expect(page).to have_content(advisee[:graduation_year])
      end

      scenario 'user fills out new advisee form incorrectly' do
        click_button('Save Advisee')

        expect(page).to have_content('There was a problem creating that '\
                                     'advisee')
        expect(page).to have_content("First name can't be blank")
        expect(page).to have_content("Last name can't be blank")
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Graduation semester can't be blank")
        expect(page).to have_content("Graduation year is not a number")
      end
    end
  end
end
