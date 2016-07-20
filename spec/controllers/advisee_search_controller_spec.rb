require 'rails_helper'

describe AdviseeSearchController, type: :controller do
  describe 'GET /api/v1/advisee_search' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:advisees) { FactoryGirl.create(:advisee, 3, user: user) }

    before do
      sign_in user
    end

    it 'returns all advisees for the current user if no search params' do
      get :index

      json_response = parse_json

      expect_json_response(response)

      advisees.each do |advisee|
        expect(json).to include(advisee)
      end
    end

    it 'returns advisees matching a search by first name' do
      searched_advisee_name = 'Karris'
      searched_advisee = FactoryGirl.create(:advisee,
                                            first_name: searched_advisee_name)

      get :index, search: searched_advisee_name.downcase

      json_response = parse_json(response)

      expect(json_response.count).to eq(1)
      expect(json_response).to include(searched_advisee)
    end

    it 'returns advisees matching a search by last name' do
      searched_advisee_name = 'Whiteoak'
      searched_advisee = FactoryGirl.create(:advisee,
                                            last_name: searched_advisee_name)

      get :index, search: searched_advisee_name.downcase

      json_response = parse_json(response)

      expect(json_response.count).to eq(1)
      expect(json_response).to include(searched_advisee)
    end

    it 'returns advisees matching a search by email' do
      searched_advisee_email = 'KWhiteoak@chromeria.gov'
      searched_advisee = FactoryGirl.create(:advisee,
                                            email: searched_advisee_email)

      get :index, search: searched_advisee_email.downcase

      json_response = parse_json(response)

      expect(json_response.count).to eq(1)
      expect(json_response).to include(searched_advisee)
    end
  end
end
