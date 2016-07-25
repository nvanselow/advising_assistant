require 'rails_helper'

describe Api::V1::AllMeetingsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/all_meetings' do
    it 'gets all meetings for the current user' do
      meetings = FactoryGirl.create_list(:meeting, 3, user: user)
      another_user = FactoryGirl.create(:user)
      another_user_meeting = FactoryGirl.create(:meeting, user: another_user)

      get :index

      json = parse_json(response)
      ids = get_meeting_ids(json)

      meetings.each do |meeting|
        expect(ids).to include(meeting.id)
      end
      expect(ids).not_to include(another_user_meeting.id)
    end
  end
end
