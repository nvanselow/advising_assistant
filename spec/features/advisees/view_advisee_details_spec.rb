require 'rails_helper'

feature 'View advisee details', %{
  As an advisor
  I want to see the details for an advisee
  So that I can view more information for an advisee
} do
  # ACCEPTANCE CRITERIA
  # [X] I can click an advisee from the list of all advisees which brings me
  #     to the details page
  # [X] The details page contains the advisees name, email address, and
  #     graduation semester and year
  # [X] An unauthenticated user cannot view the details page

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }

  scenario 'unauthenticated user attempts to view advisee details' do
    visit advisee_path(advisee)

    expect(page).to have_content('You need to sign in or sign up before '\
                                 'continuing')
    expect(page).not_to have_content(advisee.full_name)
    expect(page).not_to have_content(advisee.email)
  end

  context 'user is authenticated' do
    before do
      sign_in user
      visit advisee_path(advisee)
    end

    scenario 'user navigates to advisee details from advisees list' do
      visit advisees_path

      click_link(advisee.full_name)

      expect(page).to have_content(advisee.full_name)
      expect(page).to have_content(advisee.email)
    end

    scenario "user views their advisee's details" do
      expect(page).to have_content(advisee.first_name)
      expect(page).to have_content(advisee.last_name)
      expect(page).to have_content(advisee.email)
      expect(page).to have_content(advisee.graduation_semester)
      expect(page).to have_content(advisee.graduation_year)
    end
  end
end
