require 'rails_helper'

feature 'User creates a note for a meeting', %{
  As an advisor
  I want to add a note to a meeting
  So that I can keep track of what was discussed in the meeting
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to add a note to a meeting
  # [X] The note has a body of text
  # [X] If the note is added successfully, then I see a success message and
  #     the note is added to the list of notes for the meeting
  # [X] If there is a problem with the note, then I see an error message with
  #     information about what to fix.

  let(:user) { FactoryGirl.create(:user) }
  let(:meeting) { FactoryGirl.create(:meeting) }
  let(:note_body) { 'This is my thoughtful comment about this meeting.' }

  before do
    sign_in user
    visit meeting_path(meeting)
    click_button('Add New Note')
  end

  scenario 'User adds a note correctly' do
    find('#note_body').click
    fill_in('note_body', with: note_body)
    click_button('add-note')

    expect(page).to have_content(note_body)
  end

  scenario 'User leaves the note body blank' do
    click_button('add-note')

    expect(page).to have_content("Body can't be blank")

    expect(page).not_to have_content(note_body)
  end
end
