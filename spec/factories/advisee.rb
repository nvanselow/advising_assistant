FactoryGirl.define do
  factory :advisee do
    sequence(:first_name) { |num| "Gavin #{num}" }
    sequence(:last_name) { |num| "Guile #{num}" }
    sequence(:email) { |num| "advisee_#{num}@mailinator.com" }
    graduation_semester 'Spring'
    graduation_year '2017'
    user
  end
end
