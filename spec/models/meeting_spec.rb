require 'rails_helper'

describe Meeting, type: :model do
  describe 'validations' do
    start_time = '2014-10-31 20:00'
    end_time = '2016-01-23 18:00'
    subject do
      FactoryGirl.build(:meeting, start_time: start_time, end_time: end_time)
    end

    it do
      should have_valid(:description).when('Meeting',
                                           'Some Meeting',
                                           '',
                                           nil)
    end

    it { should validate_presence_of(:start_time) }
    it { should have_valid(:start_time).when(*valid_start_dates) }
    it { should_not have_valid(:start_time).when(*invalid_start_dates) }

    it { should validate_presence_of(:end_time) }
    it { should have_valid(:end_time).when(*valid_end_dates) }
    it { should_not have_valid(:end_time).when(*invalid_end_dates) }

    it { should validate_presence_of(:advisee) }

    it { should belong_to(:user) }
    it { should belong_to(:advisee) }
    it { should have_many(:notes) }
  end

  describe '.new_from_duration' do
    it 'sets an end time if a duration is provided' do
      duration = 90
      meeting = FactoryGirl.attributes_for(:meeting_with_duration,
                                           end_time: nil,
                                           duration: duration)
      new_meeting = Meeting.new_from_duration(meeting)

      old_start_time = DateTime.parse(meeting[:start_time])
      expect(new_meeting.end_time).to eq(old_start_time + duration.minutes)
    end

    it 'does not set the end time if no duration is provided' do
      meeting = FactoryGirl.attributes_for(:meeting, end_time: nil)

      new_meeting = Meeting.new_from_duration(meeting)

      expect(new_meeting.end_time).to eq(nil)
    end
  end

  describe '.upcomming_for_user' do
    it 'gets the meetings that are coming up for a user' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:meeting,
                              5,
                              user: user,
                              start_time: Time.zone.now + 1.day)

      expect(Meeting.upcomming_for_user(user).count).to eq(5)
    end

    it 'gets meetings that started after 1 hour ago' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:meeting,
                              2,
                              user: user,
                              start_time: Time.zone.now - 55.minutes)

      expect(Meeting.upcomming_for_user(user).count).to eq(2)
    end

    it 'does not get meetings that started more than an hour ago' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:meeting,
                              2,
                              user: user,
                              start_time: Time.zone.now - 1.day)

      expect(Meeting.upcomming_for_user(user).count).to eq(0)
    end

    it 'does not get meetings for other users' do
      user = FactoryGirl.create(:user)
      another_user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:meeting,
                              2,
                              user: another_user,
                              start_time: Time.zone.now + 1.day)

      expect(Meeting.upcomming_for_user(user).count).to eq(0)
    end
  end

  describe '.format_for_upcoming' do
    it 'returns a hash formatted with info needed for upcoming meetings' do
      meetings = FactoryGirl.create_list(:meeting, 2)

      formatted_meetings = Meeting.format_for_upcoming(meetings)

      expect(meetings.count).to eq(2)
      first_meeting = formatted_meetings[0]

      expect(first_meeting[:id]).not_to be(nil)
      expect(first_meeting[:description]).not_to be(nil)
      expect(first_meeting[:start_time]).not_to be(nil)
      expect(first_meeting[:end_time]).not_to be(nil)
      expect(first_meeting[:duration]).not_to be(nil)
      expect(first_meeting[:advisee]).not_to be(nil)
      advisee = first_meeting[:advisee]
      expect(advisee[:id]).not_to be(nil)
      expect(advisee[:full_name]).not_to be(nil)
    end
  end

  describe '#duration' do
    let(:start_time) { DateTime.new(2016, 01, 01, 11, 0, 0) }

    it 'gets the duration (in minutes) of the meeting' do
      duration = 75
      end_time = start_time + duration.minutes
      meeting = FactoryGirl.build(:meeting,
                                  start_time: start_time,
                                  end_time: end_time)

      expect(meeting.duration).to eq(duration)
    end

    it 'gets the duration for uneven times' do
      duration = 22
      end_time = start_time + duration.minutes
      meeting = FactoryGirl.build(:meeting,
                                  start_time: start_time,
                                  end_time: end_time)

      expect(meeting.duration).to eq(duration)
    end

    it 'returns 0 if a start time is missing' do
      meeting = FactoryGirl.build(:meeting, start_time: nil)

      expect(meeting.duration).to eq(0)
    end

    it 'returns 0 is the end time is missing' do
      meeting = FactoryGirl.build(:meeting, end_time: nil)

      expect(meeting.duration).to eq(0)
    end
  end

  describe '#formatted_date_only' do
    it 'ouputs only the date as a formatted string' do
      meeting = FactoryGirl.create(:meeting)

      expect(meeting.formatted_date_only).to eq('Jan 31, 2016')
    end
  end

  describe '#formatted_start_time' do
    it 'outputs the start time as a formatted string' do
      meeting = FactoryGirl.create(:meeting)

      expect(meeting.formatted_start_time).to eq('Jan 31, 2016 -  8:00 PM')
    end
  end

  describe '#formatted_time' do
    it 'outputs a formatted string with the start and end time' do
      meeting = FactoryGirl.create(:meeting)

      expect(meeting.formatted_time).to eq('Jan 31, 2016 from 8:00 PM to  '\
                                           '9:00 PM')
    end
  end
end
