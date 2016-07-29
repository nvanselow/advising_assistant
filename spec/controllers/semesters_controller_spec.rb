require 'rails_helper'

describe Api::V1::SemestersController, type: :controller do
  let(:graduation_plan) { FactoryGirl.create(:graduation_plan) }
  let(:user) { graduation_plan.advisee.user }

  before do
    sign_in user
  end

  describe 'GET /api/v1/graduation_plans/:graduation_plan_id/semesters' do
    it 'gets all semesters for a graduation plan' do
      semesters = FactoryGirl.create_list(:semester,
                                          4,
                                          graduation_plan: graduation_plan)

      get :index, graduation_plan_id: graduation_plan.id

      json = parse_json(response)
      ids = get_semester_ids(json)

      semesters.each do |semester|
        expect(ids).to include(semester.id)
      end
    end
  end
end
