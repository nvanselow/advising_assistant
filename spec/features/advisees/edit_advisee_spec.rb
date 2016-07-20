require 'rails_helper'

feature 'Edit an advisee', %{
  As an advisor
  I can edit advisee information
  So that I can make changes to that advisees information
    (e.g., name, email, graduation date)
} do
  # ACCEPTANCE CRITERIA
  # [ ] From the advisee details page, there is an option to edit an advisee
  # [ ] When I get to the form, it is pre-filled with the old advisee
  #     information
  # [ ] I can make changes and save the updated information
  # [ ] If I edit the form correctly, I get a success message, and I am
  #     returned to the advisee details page (with the updated information)
  # [ ] If I edit the form incorrectly, I get an error message, and I am
  #     returned to the form

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let(:updated_advisee) { FactoryGirl.attributes_for(:advisee) }

  before do
    sign_in user
    visit advisee_path(advisee)
  end

  scenario 'user clicks edit button on advisee details page' do
    click_link('Edit Advisee')

    expect(page).to have_content('Edit Advisee Information')
    expect(page).to have_css('form')
  end

  context 'user is on edit advisees page' do
    before do
      visit edit_advisee_path(advisee)
    end

    scenario 'user fills out edit form correctly' do
      fill_in('Email', with: updated_advisee[:email])
      fill_in('First Name', with: updated_advisee[:first_name])
      fill_in('Last Name', with: updated_advisee[:last_name])
      select('Summer', from: 'advisee_graduation_semester')
      fill_in('Graduation Year', with: updated_advisee[:graduation_year])

      click_button('Save Advisee')

      expect(page).to have_content('Advisee info updated')
      expect(page).to have_content(updated_advisee[:email])
      expect(page).to have_content(updated_advisee[:first_name])
      expect(page).to have_content(updated_advisee[:last_name])
      expect(page).to have_content('Summer')
      expect(page).to have_content(updated_advisee[:graduation_year])
    end

    scenario 'user fills out advisee edit form incorrectly' do
      fill_in('Email', with: '')
      fill_in('First Name', with: '')
      fill_in('Last Name', with: '')
      fill_in('Graduation Year', with: '')

      click_button('Save Advisee')

      expect(page).not_to have_content('Advisee info updated')
      expect(page).to have_content('There were problems updating the advisee')
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Graduation year is not a number")
    end
  end
end
