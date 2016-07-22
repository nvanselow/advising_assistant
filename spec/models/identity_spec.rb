require 'rails_helper'

describe Identity, type: :model do
  it { should have_valid(:uid).when('1235') }
  it { should_not have_valid(:uid).when('', nil) }

  it { should have_valid(:provider).when('google', 'github') }
  it { should_not have_valid(:provider).when('', nil) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
end
