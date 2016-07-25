require 'rails_helper'

feature 'User views meeting details', %{
  As an advisor
  I want to view the details of a meeting
  So that I can see all relevant info for a particular meeting with an advisee
} do
  # ACCEPTANCE CRITERIA
  # [X] I can see the meeting date
  # [X] I can see the advisee I am meeting with
  # NOTE: Other checks in js test

  let(:user) { FactoryGirl.create(:user) }
  let(:meeting) { FactoryGirl.create(:meeting) }

  before do
    sign_in user
  end

  scenario 'views the meeting details page' do
    visit meeting_path(meeting)

    expect(page).to have_content('Jan 31, 2016')
    expect(page).to have_content(meeting.advisee.full_name)
  end
end
