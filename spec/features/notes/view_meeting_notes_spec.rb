require 'rails_helper'

feature 'View notes for a meeting', %{
  As an advisor
  I want to see a list of notes for a meeting
  So that I can see what notes I have made for the meeting
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to view notes for a meeting
  # [X] This list displays all notes for a meeting in the order they
  #     were updated

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee) }
  let!(:meeting) { FactoryGirl.create(:meeting, advisee: advisee) }

  before do
    sign_in user
  end

  scenario 'navigate to the meeting notes from the advisee page' do
    note = FactoryGirl.create(:note, noteable: meeting)

    visit advisee_path(advisee)

    find('.meeting-details-link').click

    expect(page).to have_content(note.body)
  end

  scenario 'notes are ordered with most recently updated at the top' do
    old_note = FactoryGirl.create(:note,
                                  noteable: meeting,
                                  updated_at: DateTime.new(2010, 2, 3, 4, 5))
    new_note = FactoryGirl.create(:note,
                                  noteable: meeting,
                                  updated_at: DateTime.new(2016, 7, 19, 8, 0))
    note = FactoryGirl.create(:note,
                              noteable: meeting,
                              updated_at: DateTime.new(2016, 7, 4, 8, 0))

    visit meeting_path(meeting)

    expect(new_note.body).to appear_before(note.body)
    expect(new_note.body).to appear_before(old_note.body)
    expect(note.body).to appear_before(old_note.body)
  end
end
