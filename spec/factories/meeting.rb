FactoryGirl.define do
  factory :meeting do
    sequence(:title) { |num| "Meeting #{num}" }
    start_time
    end_time
    timezone
  end
end
