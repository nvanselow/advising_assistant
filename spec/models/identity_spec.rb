require 'rails_helper'

describe Identity, type: :model do
  it { should have_valid(:uid).when('1235') }
  it { should_not have_valid(:uid).when('', nil) }

  it { should have_valid(:provider).when('google', 'github') }
  it { should_not have_valid(:provider).when('', nil) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }

  describe '.find_or_create_from_omniauth' do
    let(:user) { FactoryGirl.create(:user) }
    let(:auth) { fake_omniauth }

    it 'creates a new identify if one does not exist for provider' do
      identity = Identity.find_or_create_from_omniauth(auth, user)

      expect(identity).not_to be(false)
      expect(identity.id).not_to be(nil)
      expect(identity.uid).to eq(auth['uid'])
      expect(identity.provider).to eq(auth['provider'])
      expect(identity.access_token).to eq(auth['credentials']['token'])
      expect(identity.user_id).to eq(user.id)

      datetime = Time.at(auth['credentials']['expires_at']).to_datetime
      expect(identity.expires_at).to eq(datetime)
    end

    it 'updates the identity if one already exists' do
      old_identity = FactoryGirl.create(:identity, user: user)

      identity = Identity.find_or_create_from_omniauth(auth, user)

      expect(identity.id).to eq(old_identity.id)
      expect(identity.access_token).to eq(auth['credentials']['token'])
    end
  end
end
