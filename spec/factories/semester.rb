FactoryGirl.define do
  factory :semester do
    semester 'Fall'
    sequence(:year) { |num| 2000 + num }
    remaining_courses false
    graduation_plan
  end
end
