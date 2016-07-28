require 'rails_helper'

describe AdviseesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe 'PUT /advisees/:advisee_id' do
    let(:updated_advisee) { FactoryGirl.attributes_for(:advisee) }
    it 'updates an advisee' do
      advisee = FactoryGirl.create(:advisee, user: user)

      put :update, id: advisee.id, advisee: updated_advisee

      expect(flash[:success]).to include('Advisee info updated')
    end

    it "cannot be updated by a user who didn't make the advisee" do
      advisee = FactoryGirl.create(:advisee)

      put :update, id: advisee.id, advisee: updated_advisee

      expect_controller_permission_error(response, flash)
    end
  end

  describe 'DELETE /advisees/:advisee_id' do
    it 'deletes an advisee' do
      advisee = FactoryGirl.create(:advisee, user: user)

      delete :destroy, id: advisee.id

      expect(Advisee.all.count).to eq(0)
      expect(response).to redirect_to(advisees_path)
    end

    it "cannot be deleted by a user who didn't make the advisee" do
      advisee = FactoryGirl.create(:advisee)

      delete :destroy, id: advisee.id

      expect_controller_permission_error(response, flash)
      expect(Advisee.all.count).to eq(1)
    end
  end
end
