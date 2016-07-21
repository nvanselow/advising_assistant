require 'rails_helper'

Capybara.javascript_driver = :webkit

feature 'User can edit an advisee note', %{
  As an advisor
  I want to edit a note for an advisee
  So that I can make changes to my previously created notes
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to edit a previously created note
  # [X] Clicking that option will show a form to edit the note
  # [X] If the note is edited correctly, a success message will display,
  #     and the user can see the updated note
  # [X] If the note is edited incorrectly, and error message displays that
  #     indicates what needs to be fixed. The note is not updated.

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let!(:note) { FactoryGirl.create(:note, noteable: advisee) }
  let(:updated_body) { 'I updated this note!' }

  before do
    sign_in user
    visit advisee_path(advisee)
    find('.edit-note').click
  end

  scenario 'user correctly edits a note' do
    within('.note') do
      fill_in('edit_note_body', with: updated_body)
      find('#save-note').click
    end

    expect(page).to have_content('Note updated')
    expect(page).to have_content(updated_body)
    expect(page).not_to have_content(note.body)
  end

  scenario 'user cancels the edits they made' do
    within('.note') do
      fill_in('edit_note_body', with: updated_body)
      find('#cancel_edit_note').click
    end

    expect(page).not_to have_content('Note updated')
    expect(page).not_to have_content(updated_body)
    expect(page).to have_content(note.body)
  end

  scenario 'user tries to submit an invalid advisee note' do
    within('.note') do
      note.body.length.times do
        # fill_in( with: '') was not working when all tests run
        find('#edit_note_body').click
        find('#edit_note_body').send_keys(:backspace)
      end

      find('#save-note').trigger('click')
    end

    expect(page).not_to have_content('Note updated')
    expect(page).to have_content("Body can't be blank")
  end
end
