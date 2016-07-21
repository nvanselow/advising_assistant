# require 'rails_helper'
#
# feature 'User creates a note for an advisee', %{
#   As an advisor
#   I want to leave a note for an advisee
#   So I can keep track of information for that advisee
# }, js: true do
#   # [ ] On the advisee details page, I can fill out a form to add a note
#   # [ ] If I fill out the form correctly, I see a success message and the note
#   #     is added to the top of the list of notes on the advisee details page
#   # [ ] If I fill out the form incorrectly, I see an error message with
#   #     information about what to fix and the note is not added
#   # [ ] I can add new notes without refreshing the page
#
#   let(:user) { FactoryGirl.create(:user) }
#   let(:advisee) { FactoryGirl.create(:advisee, user: user) }
#   let(:note_body) { 'This is my sweet comment about this advisee.' }
#
#   before do
#     sign_in user
#     visit advisee_path(advisee)
#   end
#
#   scenario 'User adds a note correctly' do
#     find('#note_body').trigger('click')
#     fill_in('note_body', with: note_body)
#     sleep 3
#     save_and_open_screenshot
#     click_button('add-note')
#     expect(page).to have_content(note_body)
#   end
#
#   scenario 'User leaves the note body blank' do
#     within('.add-note') do
#       find('#add-note').trigger('click')
#
#       expect(find('#note_body').value).to have_content(note_body)
#       expect(page).to have_content("Body can't be blank")
#     end
#
#     within('.notes') do
#       expect(page).not_to have_content(note_body)
#     end
#   end
# end
