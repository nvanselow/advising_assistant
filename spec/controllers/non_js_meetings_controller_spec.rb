require 'rails_helper'

describe MeetingsController, type: :controller do
  describe 'DELETE /meetings/:id' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
    end

    it 'deletes an a meeting' do
      meeting = FactoryGirl.create(:meeting, user: user)

      delete :destroy, id: meeting.id

      expect(Meeting.all.count).to eq(0)

      expect(response).to redirect_to(advisees_path)
    end
  end
end
