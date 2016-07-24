require 'rails_helper'

describe Api::V1::MicrosoftCalendarsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/microsoft_calendars' do
    it 'raises an error if there is no token' do
      expect do
        get :index
      end.to raise_error(Errors::MissingToken)
    end

    it 'raises an error if the token is expired' do
      FactoryGirl.create(:microsoft_identity,
                         user: user,
                         expires_at: (Time.now - 1.hour))

      get :index

      json = parse_json(response, :unauthorized)

      expect(json['message']).to include('Your link to Microsoft has expired.')
      expect(json['provider']).to eq('microsoft_office365')
    end

    it 'returns a list of all the calendars for the user' do
      FactoryGirl.create(:microsoft_identity, user: user)

      get :index
      json = parse_json(response)

      expect(json['calendars'].count).to eq(3)
    end
  end

  describe 'POST /api/v1/meetings/:meeting_id/microsoft_calendars' do
    let!(:identity) { FactoryGirl.create(:microsoft_identity, user: user) }
    let(:advisee) { FactoryGirl.create(:advisee, user: user) }
    let(:meeting) { FactoryGirl.create(:meeting, advisee: advisee) }

    it "adds a meeting to the user's microsoft calendar" do
      post :create, meeting_id: meeting.id

      json = parse_json(response)

      expect(json['message']).to include('Meeting added')
    end
  end
end
