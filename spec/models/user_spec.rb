require 'rails_helper'

describe User, type: :model do
  it { should have_valid(:first_name).when('Bob', 'Susie') }
  it { should_not have_valid(:first_name).when('', nil) }

  it { should have_valid(:first_name).when('Smith', 'Weeks') }
  it { should_not have_valid(:first_name).when('', nil) }
end
