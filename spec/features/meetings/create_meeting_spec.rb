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
  # [X] If the meeting is added successfully, I see a success message and
  #     the meeting is added to the meetings list
  # [X] If there is a problem with the meeting, I see an error message with
  #     information about what to fix
  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let(:meeting) { FactoryGirl.attributes_for(:meeting_with_duration) }

  before do
    sign_in user
    visit advisee_path(advisee)
    click_button('Add New Meeting')
  end

  scenario 'User can create a new meeting' do
    fill_in('meeting_description', with: meeting[:description])
    # Use js to fill in a read only input
    page.execute_script("$('#meeting_start_time_date')."\
                        "val('#{meeting[:start_time]}')")
    page.execute_script("$('#meeting_start_time_date')."\
                        "trigger('change')")
    fill_in('meeting_start_time_time', with: meeting[:start_time])
    click_button('Done')
    find('#meeting_duration').send_keys(meeting[:duration])
    find('#add_meeting').click

    expect(page).to have_content('Meeting created')

    expect(page).to have_content(meeting[:description])
  end

  scenario 'User attempts to create an invalid meeting' do
    find('#add_meeting').click

    expect(page).to have_content('There were problems creating that meeting')
    expect(page).to have_content("Start time can't be blank")
    expect(page).to have_content("End time can't be blank")
  end
end
