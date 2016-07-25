require 'rails_helper'

feature 'Delete a meeting with advisee', %{
  As an advisor
  I want to delete a meeting for an advisee
  So that I can remove meetings from the list
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to delete a meeting
  # [X] If deleted, I see a message indicating the meeting was removed
  # [X] If deleted, I am brought back to the main app page

  let(:user) { FactoryGirl.create(:user) }
  let!(:meeting) { FactoryGirl.create(:meeting, user: user) }

  before do
    sign_in user
    visit meeting_path(meeting)
  end

  scenario 'User deletes a meeting' do
    click_button('Delete Meeting')

    click_button('Yes, Delete Meeting')

    expect(page).to have_content('Meeting deleted')
    expect(page).not_to have_content(meeting.description)
  end

  scenario 'User cancels deleting a meeting' do
    click_button('Delete Meeting')

    click_link('Cancel')

    expect(page).not_to have_content('Meeting deleted')
    expect(page).to have_content(meeting.description)
  end
end
