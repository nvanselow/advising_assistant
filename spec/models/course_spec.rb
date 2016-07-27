require 'rails_helper'

describe Course, type: :model do
  it { should have_valid(:name).when('PSY 500', 'Course Name') }
  it { should_not have_valid(:name).when('', nil) }

  it { shoud validate_presence_of(:semester) }

  it { should belong_to(:semester) }
end
