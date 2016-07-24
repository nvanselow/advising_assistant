require 'rails_helper'

describe Api::V1::GoogleCalendarsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/google_calendars' do
    it 'raises an error if there is no token' do
      expect do
        get :index
      end.to raise_error(Errors::MissingToken)
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
end
