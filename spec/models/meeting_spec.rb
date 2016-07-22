require 'rails_helper'

describe Meeting, type: :model do
  describe 'validations' do
    start_time = '2014-10-31 20:00'
    end_time = '2016-01-23 18:00'
    subject do
      FactoryGirl.build(:meeting, start_time: start_time, end_time: end_time)
    end

    it { should have_valid(:description).when('Meeting',
                                              'Some Meeting',
                                              '',
                                              nil) }

    it { should validate_presence_of(:start_time) }
    it { should have_valid(:start_time).when(*valid_start_dates) }
    it { should_not have_valid(:start_time).when(*invalid_start_dates) }

    it { should validate_presence_of(:end_time) }
    it { should have_valid(:end_time).when(*valid_end_dates) }
    it { should_not have_valid(:end_time).when(*invalid_end_dates) }

    it { should validate_presence_of(:advisee) }
    it { should belong_to(:advisee) }
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
end
