require 'rails_helper'

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
                                                    10000)}

  it { should belong_to(:user) }

  describe '#full_name' do
    it 'concatenates the first and last name' do
      advisee = FactoryGirl.create(:advisee)

      expect(advisee.full_name).to eq("#{advisee.first_name} #{advisee.last_name}")
    end
  end
end
