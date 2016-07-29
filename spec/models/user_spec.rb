require 'rails_helper'

describe User, type: :model do
  it { should have_valid(:first_name).when('Bob', 'Susie') }
  it { should_not have_valid(:first_name).when('', nil) }

  it { should have_valid(:first_name).when('Smith', 'Weeks') }
  it { should_not have_valid(:first_name).when('', nil) }

  it { should have_many(:advisees).dependent(:destroy) }
  it { should have_many(:identities).dependent(:destroy) }
  it { should have_many(:meetings).dependent(:destroy) }

  describe '#can_modify?' do
    let(:user) { FactoryGirl.create(:user) }
    let(:another_user) { FactoryGirl.create(:user) }

    it 'returns true if the user is allowed to modify the resource' do
      advisee = FactoryGirl.create(:advisee, user: user)

      expect(user.can_modify?(advisee)).to be(true)
    end

    it 'returns false if the user is not allowed to modify the resource' do
      advisee = FactoryGirl.create(:advisee, user: another_user)

      expect(user.can_modify?(advisee)).to be(false)
    end
  end
end
