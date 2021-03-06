require 'rails_helper'

describe Api::V1::GoogleCalendarsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/google_calendars' do
    it 'raises an error if there is no token' do
      get :index

      json = parse_json(response, :unauthorized)

      expect(json['message']).to include('You have not linked your account to '\
                                         'Google. Redirecting you')
      expect(json['provider']).to eq('google_oauth2')
    end

    it 'raises an error if the token is expired' do
      FactoryGirl.create(:identity, user: user, expires_at: (Time.now - 1.hour))

      get :index

      json = parse_json(response, :unauthorized)

      expect(json['message']).to include('Your link to Google has expired.')
      expect(json['provider']).to eq('google_oauth2')
    end

    it 'returns a list of all the calendars for the user' do
      FactoryGirl.create(:identity, user: user)

      get :index
      json = parse_json(response)

      expect(json['calendars'].count).to eq(2)
    end
  end

  describe 'POST /api/v1/meetings/:meeting_id/google_calendars' do
    let!(:identity) { FactoryGirl.create(:identity, user: user) }
    let(:advisee) { FactoryGirl.create(:advisee, user: user) }
    let(:meeting) { FactoryGirl.create(:meeting, advisee: advisee, user: user) }

    it "adds a meeting to the user's google calendar" do
      post :create, meeting_id: meeting.id

      json = parse_json(response)

      expect(json['message']).to include('Meeting added')
    end

    it 'returns an error if the user cannot modify the meeting' do
      another_user = FactoryGirl.create(:user)
      sign_in another_user

      post :create, meeting_id: meeting.id

      json = parse_json(response, :unauthorized)

      expect(json['message']).to include('You do not have permission')
    end
  end
end
