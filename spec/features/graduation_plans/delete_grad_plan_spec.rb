require 'rails_helper'

feature 'Delete a graduation plan', %{
  As an advisor
  I want to delete a graduation plan
  So that I can get rid of graduation plans I no longer need
} do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to delete a plan
  # [X] I must confirm whether or not I want to delete the plan
  # [X] If deleted, the plan is removed from the list and I see a message
  #     indicating the plan was deleted

  let(:user) { FactoryGirl.create(:user) }
  let(:graduation_plan) { FactoryGirl.create(:graduation_plan) }

  before do
    sign_in user
    visit advisee_graduation_plans_path(graduation_plan.advisee)
  end

  scenario 'user deletes a graduation plan' do
    click_button("delete-plan-#{graduation_plan.id}")

    expect(page).to have_content('Graduation plan deleted')
    expect(page).not_to have_content(graduation_plan.name)
  end
end
