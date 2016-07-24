FactoryGirl.define do
  factory :identity do
    sequence(:uid) { |num| "uid_#{num}" }
    provider 'google_oauth2'
    access_token '123456'
    expires_at (Time.now + 1.hours)
    user

    factory :microsoft_identity do
      provider 'microsoft_office365'
    end
  end
end
