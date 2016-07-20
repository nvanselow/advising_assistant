FactoryGirl.define do
  factory :note do
    sequence(:body) { |num| "This advisee is doing awesome #{num}!"}
    noteable { |n| n.association(:advisee) }
  end
end
