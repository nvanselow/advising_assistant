require 'rails_helper'

feature 'Advisor can view all of their advisees', %{
  As an advisor
  I want to see a list of my own advisees
  So that I can see all my own advisees
} do
  # ACCEPTANCE CRITERIA
  # [X] There is a list of advisees that belong to the advisor
  # [X] The advisor cannot see another advisor's advisees
  # [X] Clicking an advisee's name will bring you to the details page
  #     for that advisee

  scenario 'An unauthenticated user cannot see a list of advisees' do
    visit root_path

    expect(page).not_to have_link('Advisees')

    visit advisees_path

    expect(page).to have_content('You need to sign in or sign up before '\
                                 'continuing')
  end

  context 'Advisor is authenticated' do
    let(:advisor) { FactoryGirl.create(:user) }
    let!(:advisees) { FactoryGirl.create_list(:advisee, 3, user: advisor) }

    before do
      sign_in advisor
      visit advisees_path
    end

    scenario 'Advisor navigates to their advisee list' do
      visit root_path
      within('#nav-links') do
        click_link('Advisees')
      end

      advisees.each do |advisee|
        expect(page).to have_content(advisee.first_name)
        expect(page).to have_content(advisee.last_name)
      end
    end

    scenario 'Advisor sees all of their advisees' do
      advisees.each do |advisee|
        expect(page).to have_content(advisee.first_name)
        expect(page).to have_content(advisee.last_name)
        expect(page).to have_content(advisee.graduation_semester)
        expect(page).to have_content(advisee.graduation_year)
      end
    end

    scenario "Advisor can't see another advisor's advisees" do
      another_advisor = FactoryGirl.create(:user)
      another_advisors_advisees = FactoryGirl.create_list(:advisee,
                                                          3,
                                                          user: another_advisor)

      visit advisees_path

      advisees.each do |advisee|
        expect(page).to have_content(advisee.first_name)
        expect(page).to have_content(advisee.last_name)
      end

      another_advisors_advisees.each do |advisee|
        expect(page).not_to have_content(advisee.first_name)
        expect(page).not_to have_content(advisee.last_name)
      end
    end

    scenario 'Clicking advisee brings you to the details page for advisee' do
      advisee = advisees.first
      click_link(advisee.full_name)

      expect(page).to have_content(advisee.full_name)
      expect(page).to have_content(advisee.email)
    end
  end
end
