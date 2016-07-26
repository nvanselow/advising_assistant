FactoryGirl.define do
  factory :graduation_plan do
    sequence(:name) { |num| "Grad Plan #{num}" }
  end
end
