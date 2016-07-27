require 'rails_helper'

describe GraduationPlan, type: :model do
  it { should have_valid(:name).when('Grad Plan 1', 'Hello') }
  it { should_not have_valid(:name).when('', nil) }

  it { should validate_presence_of(:advisee) }

  it { should belong_to(:advisee) }
  it { should have_many(:semesters) }
end
