FactoryGirl.define do
  factory :course do
    sequence(:name) { |num| "PSY 10#{num}"}
    credits 3
    semester
  end
end
