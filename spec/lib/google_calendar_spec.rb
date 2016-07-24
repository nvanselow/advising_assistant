require 'rails_helper'

describe GoogleCalendar do
  let(:user) { FactoryGirl.create(:user) }
  let(:service) { GoogleCalendar.new(user) }

  describe '.new' do
    context 'valid identity exists' do
      let!(:token) { FactoryGirl.create(:identity, user: user) }

      it 'accepts a user as a paremeter' do
        expect { service }.not_to raise_error
      end

      it 'raises an error if no user is provided' do
        expect { GoogleCalendar.new }.to raise_error(ArgumentError)
      end
    end

    it 'raises an error if the token has expired' do
      FactoryGirl.create(:identity, user: user, expires_at: Time.now - 1.hour)

      expect { service }.to raise_error(Errors::TokenExpired)
    end

    it 'raises an error if there is no identity' do
      expect { service }.to raise_error(Errors::MissingToken)
    end
  end

  describe '#get_calendars' do
    before do
      FactoryGirl.create(:identity, user: user)
    end

    it 'returns a list of Google calendars for the user' do
      calendars = service.get_calendars

      expect(calendars.count).to eq(2)

      first_calendar = calendars[0]
      expect(first_calendar.id).to eq('main@gmail.com')
      expect(first_calendar.name).to eq('main@gmail.com')
      expect(first_calendar.time_zone).to eq('America/New_York')
    end
  end

  describe '#create_meeting' do
    let(:meeting) { FactoryGirl.create(:meeting) }
    let!(:token) { FactoryGirl.create(:identity, user: user) }

    it 'adds a meeting the Google calendar for the user' do
      expect { service.create_meeting(meeting, '123') }.not_to raise_error
    end

    it 'puts the meeting on the primary calendar if an id is not provided' do
      expect { service.create_meeting(meeting) }.not_to raise_error
    end
  end
end
