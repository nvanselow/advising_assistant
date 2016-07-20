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
  let!(:advisees) { FactoryGirl.create_list(:advisee, 3, user: user) }

  before do
    sign_in user
  end

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

    find('#search').send_keys(searchable_name)

    expect(page).to have_content(searchable_advisee.full_name[0..2])

    advisees.each do |advisee|
      expect(page).not_to have_content(advisee.full_name)
    end
  end

  scenario 'Clicking an advisee goes to the details page for that advisee' do
    advisee = advisees.first

    visit advisees_path

    find_link(advisee.full_name).trigger('click')

    expect(page).to have_content(advisee.full_name)
    expect(page).to have_content(advisee.email)
  end
end
