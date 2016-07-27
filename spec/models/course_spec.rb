require 'rails_helper'

describe Course, type: :model do
  it { should have_valid(:name).when('PSY 500', 'Course Name') }
  it { should_not have_valid(:name).when('', nil) }

  it { should have_valid(:credits).when(1, 2, 3) }
  it { should_not have_valid(:credits).when('', nil, 0, 1.5) }

  it { should validate_presence_of(:semester) }

  it { should belong_to(:semester) }
end
