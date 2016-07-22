require 'rails_helper'

feature 'User can search for an advisee', %{
  As an advisor
  I want to search for an advisee
  So that I can more easily find an advisee from my list
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] There is a search box on the advisees list page
  # [X] Filling in the first name will find advisees with that first name
  #     (or similar)
  # [X] Filling in a last name will find advisees with that last name
  #     (or similar)
  # [X] Filling in an email will find advisees with that email (or similar)
  # [X] Clicking on an advisee from the search list will get me to the details
  #     page for that advisee
  # [X] Stretch Goal: Entering information in to the search bar will
  #     automatically start filtering the advisees list without a page refresh

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  context 'There are no advisees' do
    scenario 'User sees message to add an advisee when no advisees' do
      visit advisees_path

      expect(page).to have_content('You have not created any advisees')
    end
  end

  context 'The user has created advisees' do
    let!(:advisees) { FactoryGirl.create_list(:advisee, 3, user: user) }

    scenario 'User leaves search bar blank returns all advisees' do
      visit advisees_path

      advisees.each do |advisee|
        expect(page).to have_content(advisee.full_name)
      end
    end

    scenario 'User starts typing a name and only sees relevant advisees' do
      searchable_name = 'Karris'
      searchable_advisee = FactoryGirl.create(:advisee,
                                              first_name: searchable_name,
                                              user: user)
      visit advisees_path

      find('#search').send_keys(searchable_name[0..2])

      expect(page).to have_content(searchable_advisee.full_name)

      advisees.each do |advisee|
        expect(page).not_to have_content(advisee.full_name)
      end
    end

    scenario 'User searches by advisee last name' do
      searchable_name = 'Whiteoak'
      searchable_advisee = FactoryGirl.create(:advisee,
                                              last_name: searchable_name,
                                              user: user)
      visit advisees_path

      find('#search').send_keys(searchable_name[0..2])

      expect(page).to have_content(searchable_advisee.full_name)

      advisees.each do |advisee|
        expect(page).not_to have_content(advisee.full_name)
      end
    end

    scenario 'User searched by advisee email' do
      searchable_email = 'kwhiteoak@chromeria.gov'
      searchable_advisee = FactoryGirl.create(:advisee,
                                              email: searchable_email,
                                              user: user)
      visit advisees_path

      find('#search').send_keys(searchable_email[0..2])

      expect(page).to have_content(searchable_advisee.full_name)

      advisees.each do |advisee|
        expect(page).not_to have_content(advisee.full_name)
      end
    end

    scenario 'Clicking an advisee goes to the details page for that advisee' do
      advisee = advisees.first

      visit advisees_path

      find_link(advisee.full_name).click

      expect(page).to have_content(advisee.full_name)
      expect(page).to have_content(advisee.email)
    end
  end
end
