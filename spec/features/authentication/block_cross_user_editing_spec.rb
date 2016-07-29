require 'rails_helper'

feature "User's cannot edit each other's resources", %{
  As a user
  I can't edit another user's advisees, meetings, or notes
  So that I can't accidentally or maliciously ruin someone else's info
} do
  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  context 'advisees' do
    let(:advisee) { FactoryGirl.create(:advisee, user: another_user) }

    scenario "a user cannot view another user's advisee" do
      visit advisee_path(advisee)

      expect_permission_error
      expect(page).not_to have_content(advisee.full_name)
      expect(current_path).not_to eq(advisee_path(advisee))
    end

    scenario "a user cannot edit another user's advisee" do
      visit edit_advisee_path(advisee)

      expect_permission_error
      expect(current_path).not_to eq(edit_advisee_path(advisee))
    end
  end

  context 'graduation plans' do
    let(:advisee) { FactoryGirl.create(:advisee, user: another_user) }
    let(:graduation_plan) do
      FactoryGirl.create(:graduation_plan, advisee: advisee)
    end

    scenario "a user cannot view another user's graduation plans" do
      visit graduation_plan_path(graduation_plan)

      expect_permission_error
      expect(current_path).not_to eq(graduation_plan_path(graduation_plan))
    end
  end
end

def expect_permission_error
  expect(page).to have_content('You do not have permission to do that.')
end
