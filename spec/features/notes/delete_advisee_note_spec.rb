require 'rails_helper'

feature 'Delete an advisee note', %{
  As an advisor
  I want to delete a note
  So that I no longer see that note in the list of notes
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] On the advisee details page, there is an option to delete a note next
  #     to each note
  # [X] Clicking that option deletes the note and I can no longer see it in
  #     the notes list for that advisee
  # [X] If deleted, I see a success message indicated the note was removed

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let!(:note) { FactoryGirl.create(:note, noteable: advisee) }

  before do
    sign_in user
    visit advisee_path(advisee)
  end

  scenario 'User deletes a note' do
    find('.delete-note').click

    find('.ok-btn').click

    expect(page).to have_content('Note deleted')
    expect(page).not_to have_content(note.body)
  end

  scenario 'User cancels note deletion' do
    find('.delete-note').click

    find('.cancel-btn').click

    expect(page).to have_content(note.body)
    expect(page).not_to have_content('Note deleted')
  end
end
