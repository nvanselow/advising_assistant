require 'rails_helper'

describe IdentitiesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe 'GET /auth/:provider/callback' do
    it 'redirects to the advisees path after creating an identity' do
      @request.env['omniauth.auth'] = fake_omniauth

      get :create, provider: 'google_oauth2'

      expect(Identity.count).to eq(1)
      expect(response).to redirect_to(advisees_path)
    end
  end
end
