require 'rails_helper'

feature 'Send email summary', %{
  As an advisor
  I want to send an email to an advisee about the meeting
  So that I can share the meeting notes with an advisee
} do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to email a summary of the meeting
  # [X] The email will contain the meeting date, time, and any public notes

  let(:user) { FactoryGirl.create(:user) }
  let(:meeting) { FactoryGirl.create(:meeting, user: user) }
  let!(:notes) { FactoryGirl.create_list(:note, 2, noteable: meeting) }

  before do
    ActionMailer::Base.deliveries.clear

    sign_in user
    visit meeting_path(meeting)
  end

  scenario 'send a meeting summary email' do
    click_link('Email Summary')

    expect(page).to have_content('Summary email sent!')
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
