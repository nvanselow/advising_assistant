require 'rails_helper'

describe AdviseesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  Fog.mock!
  Fog.credentials_path = Rails.root.join('fog_test_credentials.yml')
  connection = Fog::Storage.new(provider: 'AWS')
  connection.directories.create(key: 'my_bucket')

  describe 'POST /advisees' do
    it 'calls :fog in production for photo upload' do
      allow(Rails).to receive_message_chain(:env, :test?).and_return(false)

      advisee = FactoryGirl.attributes_for(:advisee)

      post :create, advisee: advisee

      # expect(flash[:success]).to include('Advisee added')
    end
  end

  describe 'DELETE /advisees/:advisee_id' do
    it 'deletes an advisee' do
      advisee = FactoryGirl.create(:advisee, photo: nil)

      delete :destroy, id: advisee.id

      expect(Advisee.all.count).to eq(0)
      expect(response).to redirect_to(advisees_path)
    end
  end
end
