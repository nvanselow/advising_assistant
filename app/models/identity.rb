class Identity < ActiveRecord::Base
  belongs_to :user

  validates :uid, presence: true
  validates :provider, presence: true
  validates :user, presence: true

  def self.find_or_create_from_omniauth(auth, current_user)
    provider = auth.provider
    uid = auth.uid

    find_or_create_by(provider: provider, uid: uid) do |identity|
      identity.provider = provider
      identity.uid = uid
      identity.user = current_user
    end
  end
end
