require 'rails_helper'

feature 'View graduation plans', %{
  As an advisor
  I want to view graduation plans I have created for an advisee
  So that I can see what graduation plans have been created
} do
  # ACCEPTANCE CRITERIA
  # [ ] There is an option to view grad plans from the advisee page
  # [ ] I can see a list of all grad plans for that advisee

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let!(:grad_plans) do
    FactoryGirl.create_list(:graduation_plan, 3, advisee: advisee)
  end

  before do
    sign_in user
  end

  scenario 'user views the grad plans from the advisee page' do
    visit advisee_path(advisee)

    click_link('Graduation Plans')

    grad_plans.each do |grad_plan|
      expect(page).to have_content(grad_plan.name)
    end
  end
end
