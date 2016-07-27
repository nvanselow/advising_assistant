require 'rails_helper'

describe Semester, type: :model do
  it { should have_valid(:semester).when('Fall', 'Winter', 'Spring', 'Summer') }
  it { should_not have_valid(:semester).when('', nil, 'something') }

  it { should have_valid(:year).when(2000, 2020, 1995) }
  it { should_not have_valid(:year).when('abc', '', nil) }

  it { should have_valid(:remaining_courses).when(true, false) }

  it { should validate_presence_of(:graduation_plan) }

  it { should belong_to(:graduation_plan) }
end
