require 'rails_helper'

describe MicrosoftCalendar do
  let(:user) { FactoryGirl.create(:user) }
  let(:service) { MicrosoftCalendar.new(user) }

  describe '.new' do
    context 'a valid identity exists' do
      before do
        FactoryGirl.create(:microsoft_identity, user: user)
      end

      it 'accepts a user as a paremeter' do
        expect { service }.not_to raise_error
      end

      it 'raises an error if there is no user' do
        expect { MicrosoftCalendar.new }.to raise_error(Errors::MissingUser)
      end
    end

    it 'raises an error if the identity has expired' do
      FactoryGirl.create(:microsoft_identity,
                         user: user,
                         expires_at: Time.now - 1.hour)
      expect { service }.to raise_error(Errors::TokenExpired)
    end

    it 'returns nil if there is no identity for the microsoft provider' do
      expect { service }.to raise_error(Errors::MissingToken)
    end
  end

  describe '#get_calendars' do
    let!(:identity) { FactoryGirl.create(:microsoft_identity, user: user) }

    it 'returns list of Microsoft calendars that belong to the user as hash' do
      expect(service.get_calendars).to eq(
        [
          {
            id: "calendar_1",
            name: "Calendar",
            color: "Auto",
            change_key: "change_key_1"
          },
          {
            id: "calendar_2",
            name: "United Statesholidays",
            color: "Auto",
            change_key: "change_key_2"
          },
          {
            id: "calendar_3",
            name: "Birthdays",
            color: "Auto",
            change_key: "change_key_3"
          }
        ]
      )
    end
  end

  describe '#create_meeting' do
    let!(:identity) { FactoryGirl.create(:microsoft_identity, user: user) }
    let(:meeting) { FactoryGirl.create(:meeting) }
    it 'creates a new event (based on meeting) on the specified calendar' do
      expect(service.create_meeting(meeting)).to eq(
        id: 'fake event',
        description: 'some description'
      )
    end

    it 'has an optional calendar id parameter' do
      expect(service.create_meeting(meeting, 'id of calendar')).to eq(
        id: 'fake event',
        description: 'some description'
      )
    end
  end
end
