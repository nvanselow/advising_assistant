require 'rails_helper'

feature 'View all meetings with advisee', %{
  As an advisor
  I want to view a list of all meetings with an advisee
  So that I can see what meetings have been scheduled with all my advisees
}, js: true do
  # ACCEPTANCE CRITERIA
  # [X] There is an option to see all meetings with an advisee on the advisee
  #     details page
  # [X] I can view a list of all meetings with a particular advisee

  let(:user) { FactoryGirl.create(:user) }
  let(:advisee) { FactoryGirl.create(:advisee, user: user) }
  let!(:meetings) { FactoryGirl.create_list(:meeting, 2, advisee: advisee) }

  before do
    sign_in user
  end

  scenario 'user sees all meetings with an advisee' do
    visit advisee_path(advisee)

    meetings.each do |meeting|
      expect(page).to have_content(meeting.description)
    end
  end
end
