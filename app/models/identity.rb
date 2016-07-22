class Identity < ActiveRecord::Base
  belongs_to :user

  validates :uid, presence: true
  validates :provider, presence: true
  validates :user, presence: true

  def self.find_or_create_from_omniauth(auth, current_user)
    provider = auth.provider
    uid = auth.uid

    find_or_create_by(provider: provider, uid: uid) do |identity|
      credentials = auth['credentials']

      identity.provider = provider
      identity.uid = uid
      identity.user = current_user
      identity.access_token = credentials['token']
      identity.expires_at = Time.at(credentials['expires_at']).to_datetime
    end
  end
end
