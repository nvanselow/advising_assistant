require 'rails_helper'

describe Api::V1::CoursesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:semester) { FactoryGirl.create(:semester) }

  before do
    sign_in user
  end

  describe 'POST /api/v1/semesters/:semester_id/courses' do
    it 'creates a new course' do
      name = 'PSY 100'
      post :create, semester_id: semester.id, course: { name: name }

      json = parse_json(response)

      expect(json['message']).to include('Course created')
      expect(json['course']['id']).not_to be(nil)
      expect(json['course']['name']).to eq(name)
    end

    it 'returns errors if the course is invalid' do
      post :create, semester_id: semester.id, course: { name: '' }

      json = parse_json(response, :bad_request)

      expect(json['message']).to include('There was a problem')
      expect(json['errors']).to include("Name can't be blank")
    end
  end

  describe 'DELETE /api/v1/courses/:course_id' do
    it 'deletes a course' do
      course = FactoryGirl.create(:course)

      delete :destroy, id: course.id

      json = parse_json(response)

      expect(json['message']).to include('Course deleted')
      expect(json['course_id'].to_i).to eq(course.id)
    end
  end
end
