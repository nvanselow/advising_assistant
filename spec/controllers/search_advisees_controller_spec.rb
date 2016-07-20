require 'rails_helper'

describe Api::V1::SearchAdviseesController, type: :controller do
  describe 'GET /api/v1/advisee_search' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:advisees) { FactoryGirl.create_list(:advisee, 3, user: user) }

    before do
      sign_in user
    end

    it 'returns all advisees for the current user if no search params' do
      get :index

      json_response = parse_json(response)
      ids = get_ids(json_response)

      advisees.each do |advisee|
        expect(ids).to include(advisee.id)
      end
    end

    it 'returns advisees matching a search by first name' do
      searched_advisee_name = 'Karris'
      searched_advisee = FactoryGirl.create(:advisee,
                                            first_name: searched_advisee_name,
                                            user: user)

      get :index, search: searched_advisee_name.downcase

      json_response = parse_json(response)
      ids = get_ids(json_response)

      expect(ids.count).to eq(1)
      expect(ids).to include(searched_advisee.id)
    end

    it 'returns partial name matches' do
      searched_advisee = FactoryGirl.create(:advisee,
                                            last_name: 'Bogan',
                                            user: user)

      get :index, search: 'bog'

      json_response = parse_json(response)
      ids = get_ids(json_response)

      expect(ids.count).to eq(1)
      expect(ids).to include(searched_advisee.id)
    end

    it 'returns advisees matching a search by last name' do
      searched_advisee_name = 'Whiteoak'
      searched_advisee = FactoryGirl.create(:advisee,
                                            last_name: searched_advisee_name,
                                            user: user)

      get :index, search: searched_advisee_name.downcase

      json_response = parse_json(response)
      ids = get_ids(json_response)

      expect(ids.count).to eq(1)
      expect(ids).to include(searched_advisee.id)
    end

    it 'returns advisees matching a search by email' do
      searched_advisee_email = 'KWhiteoak@chromeria.gov'
      searched_advisee = FactoryGirl.create(:advisee,
                                            email: searched_advisee_email,
                                            user: user)

      get :index, search: searched_advisee_email.downcase

      json_response = parse_json(response)
      ids = get_ids(json_response)

      expect(ids.count).to eq(1)
      expect(ids).to include(searched_advisee.id)
    end
  end
end

def get_ids(json)
  json['advisees'].map { |c| c['id'] }
end
