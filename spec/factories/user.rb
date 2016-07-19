FactoryGirl.define do
  factory :user do
    sequence(:email) { |num| "user_#{num}@mailinator.com" }
    sequence(:first_name) { |num| "Bob #{num}" }
    last_name 'Smith'
    password 'password'
  end
end
