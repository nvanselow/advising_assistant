FactoryGirl.define do
  factory :advisee do
    sequence(:first_name) { |num| "Gavin #{num}" }
    sequence(:last_name) { |num| "Guile #{num}" }
    sequence(:email) { |num| "advisee_#{num}@mailinator.com" }
    graduation_semester 'Spring'
    graduation_year '2017'
    photo File.open("#{Rails.root}/spec/support/images/sample_avatar.jpg")
    user
  end
end
