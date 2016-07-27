FactoryGirl.define do
  factory :course do
    sequence(:name) { |num| "PSY 10#{num}"}
    semester
  end
end
