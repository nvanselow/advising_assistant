require 'rails_helper'

feature 'Delete a meeting with advisee', %{
  As an advisor
  I want to delete a meeting for an advisee
  So that I can remove meetings from the list
}, js: true do
  # ACCEPTANCE CRITERIA
  # [ ] There is an option to delete a meeting
  # [ ] Deleting a meeting removes it from the list
  # [ ] If deleted, I see a message indicating the meeting was removed
  # [ ] If deleted, I am brought back to the main meetings index for that
  #     advisee

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let!(:meeting) { FactoryGirl.create(:meeting, advisee: advisee) }

  before do
    sign_in user
    visit advisee_path(advisee)
  end

  scenario 'User deletes a meeting' do
    find('.delete-meeting').click

    expect(page).to have_content('Meeting deleted')
    expect(page).not_to have_content(meeting.description)
  end
end
