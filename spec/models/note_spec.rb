require 'rails_helper'

describe Note, type: :model do
  it { should have_valid(:body).when('Some note text') }
  it { should_not have_valid(:body).when('', nil) }
end
