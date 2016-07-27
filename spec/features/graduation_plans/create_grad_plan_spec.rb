require 'rails_helper'

feature 'Create a graduation plan', %{
  As an advisor
  I want to create a new graduation plan
  So that I have a place to organize courses for my advisee
} do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to create a graduation plan on the index page
  # [X] I must provide a name for the graduation plan

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee) }

  before do
    sign_in user
  end

  scenario 'user creates a new graduation plan' do
    grad_plan = FactoryGirl.attributes_for(:graduation_plan)

    visit advisee_graduation_plans_path(advisee)

    click_link('Add Graduation Plan')

    fill_in('Name', with: grad_plan[:name])
    click_button('Save Graduation Plan')

    expect(page).to have_content('Graduation plan created')
  end

  scenario 'user tries to submit an invalid graduation plan' do
    visit new_advisee_graduation_plan_path(advisee.id)

    click_button('Save Graduation Plan')

    expect(page).to have_content('There was a problem with that '\
                                 'graduation plan')
    expect(page).to have_content("Name can't be blank")
  end
end
