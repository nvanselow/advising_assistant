require 'rails_helper'

describe Api::V1::GraduationPlansController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:graduation_plan) { FactoryGirl.create(:graduation_plan) }

  before do
    sign_in user
  end

  describe 'PUT /api/v1/graduation_plans/:id' do
    it 'updates the graduation plan name' do
      new_name = 'Updated Plan'

      put :update, id: graduation_plan.id, graduation_plan: { name: new_name }

      json = parse_json(response)

      expect(json['message']).to include('Plan name updated')
      expect(json['graduation_plan']['name']).to eq(new_name)
    end

    it 'returns errors if the plan name is blank' do
      put :update, id: graduation_plan.id, graduation_plan: { name: '' }

      json = parse_json(response, :bad_request)

      expect(json['message']).to include('There was a problem')
      expect(json['errors']).to include("Name can't be blank")
    end
  end
end
