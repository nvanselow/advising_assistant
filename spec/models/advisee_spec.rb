require 'rails_helper'
require 'digest/md5'

describe Advisee, type: :model do
  it { should have_valid(:first_name).when('Bob', 'Susie') }
  it { should_not have_valid(:first_name).when('', nil) }

  it { should have_valid(:last_name).when('Smith', 'Weeks') }
  it { should_not have_valid(:last_name).when('', nil) }

  it { should have_valid(:email).when('test@email.com', 'test+1@advisor.edu') }
  it { should_not have_valid(:email).when('', nil, 'test', 'myemail.com') }

  it { should have_valid(:graduation_semester).when('Fall', 'Spring') }
  it { should_not have_valid(:graduation_semester).when('', nil, 'Autumn') }

  it { should have_valid(:graduation_year).when('2016', 2020) }
  it { should_not have_valid(:graduation_year).when('',
                                                    nil,
                                                    'ab',
                                                    1970,
                                                    10_000) }

  it { should belong_to(:user) }
  it { should have_many(:notes).dependent(:destroy) }

  describe '.all_for' do
    it 'returns all advisee for a user' do
      user = FactoryGirl.create(:user)
      expected_advisees = FactoryGirl.create_list(:advisee, 3, user: user)

      advisees = Advisee.all_for(user)

      expected_advisees.each do |advisee|
        expect(advisees).to include(advisee)
      end
    end

    it "does not return another user's advisees" do
      user = FactoryGirl.create(:user)
      another_user = FactoryGirl.create(:user)
      FactoryGirl.create_list(:advisee, 3, user: another_user)

      advisees = Advisee.all_for(user)

      expect(advisees.count).to eq(0)
    end
  end

  describe '#full_name' do
    it 'concatenates the first and last name' do
      advisee = FactoryGirl.create(:advisee)

      expect(advisee.full_name).to eq("#{advisee.first_name} #{advisee.last_name}")
    end
  end

  describe '#photo_url' do
    it 'returns the url of the uploaded photo if a photo exists' do
      advisee = FactoryGirl.create(:advisee)

      expect(advisee.photo_url).to eq("/uploads/advisee/photo/#{advisee.id}"\
                                      "/sample_avatar.jpg")
    end

    it 'returns a gravatar url if no photo has been uploaded' do
      advisee = FactoryGirl.create(:advisee, photo: nil)

      expect(advisee.photo_url).to eq('https://www.gravatar.com/avatar/'\
                                      "#{Digest::MD5.hexdigest(advisee.email)}")
    end
  end
end
