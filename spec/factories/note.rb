FactoryGirl.define do
  factory :note do
    sequence(:body) { |num| "This advisee is doing awesome #{num}!" }
  end
end
