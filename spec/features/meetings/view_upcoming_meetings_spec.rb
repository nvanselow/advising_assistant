require 'rails_helper'

feature 'View upcoming meetings', %{
  As an advisor
  I want to view a list of all upcoming meetings across advisees
  So I can see a list of all meetings I have coming up soon
}, js: true do
  # [X] The meeting list displays all meetings across advisees
  #     ordered by start time
  # [X] The list starts an hour before the current time
  # [X] There is an option to see previous meetings (before current time)
  # [X] Clicking on a meeting description or start time shows the details of
  #     that meeting
  # [X] Clicking on an advisee's name goes to the show page for that advisee

  let(:user) { FactoryGirl.create(:user) }
  let!(:advisee1) { FactoryGirl.create(:advisee, user: user) }
  let!(:advisee2) { FactoryGirl.create(:advisee, user: user) }

  before do
    sign_in user
  end

  context 'There are many upcoming meetings' do
    let!(:advisee1_upcomming_meeting) do
      FactoryGirl.create(:meeting,
                         start_time: Time.zone.now,
                         advisee: advisee1,
                         user: user)
    end
    let!(:advisee1_old_meeting) do
      FactoryGirl.create(:meeting,
                         start_time: Time.zone.now - 1.day,
                         advisee: advisee1,
                         user: user)
    end
    let!(:advisee2_upcomming_meeting) do
      FactoryGirl.create(:meeting,
                         start_time: Time.zone.now - 30.minutes,
                         advisee: advisee2,
                         user: user)
    end

    scenario 'view upcoming meetings on the advisees list (main page)' do
      visit advisees_path

      expect(page).to have_content(advisee1_upcomming_meeting.description)
      expect(page).to have_content(advisee2_upcomming_meeting.description)
      expect(page).not_to have_content(advisee1_old_meeting.description)

      expect(advisee1_upcomming_meeting.description)
        .to appear_before(advisee2_upcomming_meeting.description)
    end

    context 'There is an old meeting' do
      let!(:old_meeting) do
        FactoryGirl.create(:meeting,
                           user: user,
                           start_time: Time.zone.now - 1.day)
      end

      scenario 'User clicks "all meetings" to see the older meetings' do
        visit advisees_path

        expect(page).not_to have_content(old_meeting.description)

        click_button('Show All Meetings')

        expect(page).to have_content(old_meeting.description)
      end

      scenario 'User hides "all meetings" to only see upcomming meetings' do
        visit advisees_path

        click_button('Show All Meetings')
        expect(page).to have_content(old_meeting.description)

        click_button('Hide All Meetings')
        expect(page).not_to have_content(old_meeting.description)
      end
    end
  end

  context 'there is one upcoming meeting' do
    let!(:meeting) do
      FactoryGirl.create(:meeting,
                         start_time: Time.zone.now,
                         advisee: advisee1,
                         user: user)
    end

    scenario 'user clicks on the meeting time to see the meeting details' do
      note = FactoryGirl.create(:note, noteable: meeting)

      visit advisees_path
      find('.meeting-details-link').click

      expect(page).to have_content(meeting.description)
      expect(page).to have_content('Meeting with')
      expect(page).to have_content(advisee1.full_name)
      expect(page).to have_content(note.body)
    end

    scenario 'user clicks the advisee name to see the advisee details' do
      visit advisees_path

      click_link(advisee1.full_name)

      expect(page).to have_content(advisee1.full_name)
      expect(page).to have_content(advisee1.graduation_semester)
      expect(page).to have_content(advisee1.graduation_year)
      expect(page).not_to have_content('Meeting with')
    end
  end
end
