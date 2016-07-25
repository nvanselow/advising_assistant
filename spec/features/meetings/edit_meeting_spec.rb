require 'rails_helper'

feature 'Edit a meeting', %{
  As an advisor
  I want to edit a meeting for an advisee
  So that I can update the meeting if there is a change
} do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to edit the meeting
  # [X] When first editing the form, I can see the original meeting information
  # [X] If the meeting is edited successfully, I see a success message and
  #     the updated meeting information appears in the list
  # [ ] If there is a problem with the changed meeting, I see an error message
  #     with information about what to fix.

  let(:user) { FactoryGirl.create(:user) }
  let(:meeting) { FactoryGirl.create(:meeting, user: user) }

  before do
    sign_in user
  end

  scenario 'user updates the meeting' do
    updated_start_time = '2016-07-25T08:00:00+00:00'
    updated_duration = 40
    updated_description = 'Updated Description'

    visit meeting_path(meeting)

    click_link('Edit Meeting')

    fill_in('Description', with: updated_description)
    fill_in('Start Time', with: updated_start_time)
    fill_in('Duration', with: updated_duration)
    click_button('Save Meeting')

    expect(page).to have_content(updated_description)
    expect(page).to have_content('Jul 25, 2016 from 8:00 AM to 8:40 AM')
  end

  scenario 'user fills out the form incorrectly' do
    visit edit_meeting_path(meeting)

    fill_in('Start Time', with: '')
    click_button('Save Meeting')

    expect(page).to have_content('There were problems updating that meeting')
    expect(page).to have_content("Start time can't be blank")
  end
end
