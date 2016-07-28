require 'rails_helper'

describe MeetingSummariesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:meeting) { FactoryGirl.create(:meeting, user: user) }

  before do
    ActionMailer::Base.deliveries.clear
    sign_in user
  end

  describe 'POST /meetings/:meeting_id/meeting_summaries' do
    it 'sends and email summary of the meeting' do
      post :create, meeting_id: meeting.id

      expect(flash[:success]).to include('Summary email sent')
      expect(response).to redirect_to(meeting_path(meeting))
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'does not allow another user to send a summary' do
      meeting = FactoryGirl.create(:meeting)

      post :create, meeting_id: meeting.id

      expect_controller_permission_error(response, flash)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end
end
