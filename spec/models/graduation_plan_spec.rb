require 'rails_helper'

describe GraduationPlan, type: :model do
  it { should belong_to(:advisee) }
end
