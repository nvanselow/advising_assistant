require 'rails_helper'

describe Api::V1::MeetingsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/advisees/:advisee_id/meetings' do
    it 'returns all meetings for an advisee' do
      meetings = FactoryGirl.create_list(:meeting, 4, advisee: advisee)

      get :index, advisee_id: advisee.id

      json_response = parse_json(response)
      ids = get_meeting_ids(json_response)

      meetings.each do |meeting|
        expect(ids).to include(meeting.id)
      end
    end

    it 'returns meetings sorted with the most recent first' do
      old_meeting = FactoryGirl.create(:meeting,
                                       advisee: advisee,
                                       start_time: DateTime.new(2010, 5, 1, 8, 0),
                                       end_time: DateTime.new(2010, 5, 1, 9, 0))
      new_meeting = FactoryGirl.create(:meeting,
                                       advisee: advisee,
                                       start_time: DateTime.new(2016, 7, 20, 8, 0),
                                       end_time: DateTime.new(2016, 7, 20, 9, 0))
      meeting = FactoryGirl.create(:meeting,
                                   advisee: advisee,
                                   start_time: DateTime.new(2016, 7, 19, 8, 0),
                                   end_time: DateTime.new(2016, 7, 19, 9, 0))

      get :index, advisee_id: advisee.id

      json_response = parse_json(response)
      ids = get_meeting_ids(json_response)

      expect(ids).to eq([new_meeting.id, meeting.id, old_meeting.id])
    end
  end

  describe 'POST /api/v1/advisees/:advisee_id/meetings' do
    it 'creates a new meeting if a valid meeting is provided' do
      meeting = FactoryGirl.attributes_for(:meeting_with_duration)

      post :create, advisee_id: advisee.id, meeting: meeting

      json_response = parse_json(response)

      db_meeting = Meeting.first
      expect(json_response['message']).to include('Meeting created')
      expect(json_response['meeting']['id']).to eq(db_meeting.id)

      expect(db_meeting.description).to eq(meeting[:description])
      expect(db_meeting.start_time).to eq(meeting[:start_time])
      expect(db_meeting.end_time).to eq(meeting[:end_time])
    end

    it 'returns errors if the meeting is invalid' do
      post :create, advisee_id: advisee.id, meeting: {
        description: '',
        start_time: '',
        duration: '',
      }

      json_response = parse_json(response, :bad_request)

      expect(json_response['message']).to include('There were problems '\
                                                  'creating that meeting')
      errors = json_response['errors']
      expect(errors).to include("Start time can't be blank")
      expect(errors).to include("End time can't be blank")
    end
  end

  describe 'PUT /api/v1/meetings/:id' do
    it 'updates an existing meeting' do
      meeting = FactoryGirl.create(:meeting)

      put :update, id: meeting.id, meeting: {
        description: 'Updated!'
      }

      json_response = parse_json(response)

      expect(json_response['message']).to include('Meeting updated')
      expect(json_response['meeting']['description']).to include('Updated!')
    end

    it 'returns error is the meeting is invalid' do
      meeting = FactoryGirl.create(:meeting)

      put :update, id: meeting.id, meeting: {
        description: '',
        start_time: '',
        duration: '',
      }

      json_response = parse_json(response, :bad_request)

      expect(json_response['message']).to include('There were problems '\
                                                  'updating that meeting')
      errors = json_response['errors']
      expect(errors).to include("Start time can't be blank")
    end
  end

  describe 'DELETE /api/v1/meetings/:id' do
    it 'deletes a meeting' do
      meeting = FactoryGirl.create(:meeting)

      delete :destroy, id: meeting.id

      json_response = parse_json(response)

      expect(json_response['message']).to include('Meeting deleted')
    end
  end
end

def get_meeting_ids(json)
  json['meetings'].map { |c| c['id'] }
end
