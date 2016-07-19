FactoryGirl.define do
  factory :user do
    sequence(:email) { |num| "user_#{num}@mailinator.com" }
    password 'password'
  end
end
