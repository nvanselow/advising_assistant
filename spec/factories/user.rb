FactoryGirl.define do
  factory :user do
    sequence(:email) { |num| "user_#{num}@mailinator.com" }
    password 'password'
    sequence(:first_name) { |num| "Bob #{num}" }
    last_name 'Smith'
  end
end
