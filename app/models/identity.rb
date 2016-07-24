class Identity < ActiveRecord::Base
  belongs_to :user

  validates :uid, presence: true
  validates :provider, presence: true
  validates :user, presence: true

  def self.find_or_create_from_omniauth(auth, current_user)
    provider = auth.provider
    uid = auth.uid
    access_token = auth['credentials']['token']
    expires_at = Time.at(auth['credentials']['expires_at']).to_datetime

    identity = where(user: current_user, provider: provider, uid: uid).first

    if(identity)
      identity.access_token = access_token
      identity.expires_at = expires_at
      identity.save
    else
      create({
        provider: provider,
        uid: uid,
        user: current_user,
        access_token: access_token,
        expires_at: expires_at
      })
    end
  end
end
