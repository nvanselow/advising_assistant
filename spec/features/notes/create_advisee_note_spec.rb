require 'rails_helper'

feature 'User creates a note for an advisee', %{
  As an advisor
  I want to leave a note for an advisee
  So I can keep track of information for that advisee
}, js: true do
  # [ ] On the advisee details page, I can fill out a form to add a note
  # [ ] If I fill out the form correctly, I see a success message and the note
  #     is added to the top of the list of notes on the advisee details page
  # [ ] If I fill out the form incorrectly, I see an error message with
  #     information about what to fix and the note is not added
  # [ ] I can add new notes without refreshing the page

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let(:comment_body) { 'This is my sweet comment about this advisee.' }

  before do
    sign_in user
    visit advisee_path(advisee)
  end

  scenario 'User adds a note correctly' do
    within('.add-note') do
      fill_in(:body, with: comment_body)
      find('#add-advisee').trigger('click')

      expect(find('#body').value).to have_content(comment_body)
    end

    within('.notes') do
      expect(page).to have_content(comment_body)
    end
  end

  scenario 'User leaves the comment body blank' do
    within('.add-note') do
      find('#add-advisee').trigger('click')

      expect(page).to have_content("Body can't be blank")
    end

    within('.notes') do
      expect(page).not_to have_content(comment_body)
    end
  end
end
