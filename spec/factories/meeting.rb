FactoryGirl.define do
  factory :meeting do
    sequence(:description) { |num| "Meeting #{num}" }
    start_time '2016-01-31 20:00'
    end_time '2016-01-31 21:00'
    time_zone 'Eastern Time (US & Canada)'
    advisee
  end
end
