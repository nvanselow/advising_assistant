require 'rails_helper'

describe AdviseesController, type: :controller do
  describe 'DELETE /advisees/:advisee_id' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
    end

    it 'deletes an advisee' do
      advisee = FactoryGirl.create(:advisee)

      delete :destroy, id: advisee.id

      expect(Advisee.all.count).to eq(0)
    end
  end
end
