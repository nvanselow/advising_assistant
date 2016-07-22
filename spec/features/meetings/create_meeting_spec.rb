require 'rails_helper'

feature 'Create a meeting', %{
  As an advisor
  I want to create a meeting for an advisee
  So that I can keep track of meetings with one of my advisees
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to add a meeting for an advisee
  # [X] I can set the start time and end time for the meeting
  # [X] I can optionally give the meeting a brief name/description
  # [X] If the meeting is added successfully, I see a success message and the meeting is added to the meetings list
  # [ ] If there is a problem with the meeting, I see an error message with information about what to fix
  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let(:meeting) { FactoryGirl.attributes_for(:meeting) }

  before do
    sign_in user
    visit advisee_path(advisee)
  end

  scenario 'User can create a new meeting' do
    fill_in('meeting_title', with: meeting[:description])
    fill_in('meeting_start_time', with: meeting[:start_time])
    fill_in('meeting_end_time', with: meeting[:end_time])
    select(meeting[:timezone], from: 'meeting_timezone')
    find('#save-meeting').click

    expect(page).to have_content('Meeting created')

    within('.meetings') do
      expect(page).to have_content(meeting[:description])
    end
  end

  scenario 'User attempts to create an invalid meeting' do
    find('#save-meeting').click

    expect(page).to have_content('There were problems creating the meeting')
    expect(page).to have_content("Start time can't be blank")
    expect(page).to have_content("End time can't be blank")
  end

end
