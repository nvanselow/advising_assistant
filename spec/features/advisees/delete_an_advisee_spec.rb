require 'rails_helper'

feature 'Delete an advisee', %{
  As an advisor
  I can delete an advisee
  So that I can remove the advisee from my list and any information associated
    with the advisee
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] From the advisee details page, there is an option to delete an advisee
  # [X] I am asked to be sure I want to delete the advisee
  # [X] If I agree, that advisee, and all notes, meetings, and graduation
  #     plans are also deleted
  # [X] If I cancel, the advisee is not deleted
  # [X] If deleted, I see a success message
  # [X] If deleted, I am brought back the the list of advisees

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }

  before do
    sign_in user
    visit advisee_path(advisee)
  end

  scenario 'user sees delete button on advisee details page' do
    expect(page).to have_button('Delete Advisee')
  end

  scenario 'User clicks the delete button for an advisee' do
    click_button('Delete Advisee')

    click_button('Yes, Delete Advisee')

    expect(page).to have_content('Advisee deleted successfully')
    expect(page).to have_content('Advisees')
  end

  scenario 'User cancels delete when asked to confirm' do
    click_button('Delete Advisee')

    click_link('Cancel')

    expect(page).to have_content(advisee.full_name)
  end
end
