require 'rails_helper'

describe Api::V1::NotesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe 'PUT /api/v1/notes/:id' do
    it 'updates an existing note' do
      original_note = FactoryGirl.create(:note)
      updated_body = 'I was updated!'
      put :update, id: original_note.id,
                   note: { body: updated_body }

      json_response = parse_json(response)

      expect(json_response['message']).to include('Note updated')
    end

    it 'returns errors if the note is invalid' do
      note = FactoryGirl.create(:note)

      put :update, id: note.id,
                   note: { body: '' }

      json_response = parse_json(response, :bad_request)

      expect(json_response['errors']).to include("Body can't be blank")
    end
  end

  describe 'DELETE /api/v1/notes/:id' do
    it 'deletes a note' do
      note = FactoryGirl.create(:note)

      delete :destroy, id: note.id

      json_response = parse_json(response)

      expect(json_response['message']).to include('Note deleted')
    end
  end
end
