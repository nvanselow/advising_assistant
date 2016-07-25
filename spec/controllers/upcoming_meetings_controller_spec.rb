require 'rails_helper'

describe Api::V1::UpcomingMeetingsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/upcomming_meetings' do
    it 'returns all upcomming meetings' do
      upcomming_meetings = FactoryGirl.create_list(:meeting,
                                                   3,
                                                   user: user,
                                                   start_time: Time.zone.now)
      old_meeting = FactoryGirl.create(:meeting,
                                       user: user,
                                       start_time: Time.zone.now - 1.day)

      get :index

      json = parse_json(response)
      ids = get_meeting_ids(json)

      upcomming_meetings.each do |meeting|
        expect(ids).to include(meeting.id)
      end
      expect(ids).not_to include(old_meeting.id)
    end
  end
end
