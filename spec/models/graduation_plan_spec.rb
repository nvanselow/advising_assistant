require 'rails_helper'

describe GraduationPlan, type: :model do
  it { should have_valid(:name).when('Grad Plan 1', 'Hello') }
  it { should_not have_valid(:name).when('', nil) }

  it { should validate_presence_of(:advisee) }

  it { should belong_to(:advisee) }
  it { should have_many(:semesters).dependent(:destroy) }

  describe '#create_default_semesters' do
    it 'creates a fall, spring, and summer semester for four years '\
       'before the graduation year' do
      advisee = FactoryGirl.create(:advisee,
                                   graduation_semester: 'Spring',
                                   graduation_year: 2016)
      graduation_plan = FactoryGirl.create(:graduation_plan, advisee: advisee)

      created_semesters = graduation_plan.create_default_semesters
      created_semesters_array = reformat_semesters(created_semesters)

      expected_semesters_array = [
        'Remaining 1991',
        'Fall 2012',
        'Spring 2013',
        'Summer 2013',
        'Fall 2013',
        'Spring 2014',
        'Summer 2014',
        'Fall 2014',
        'Spring 2015',
        'Summer 2015',
        'Fall 2015',
        'Spring 2016',
        'Summer 2016'
      ]

      expect(created_semesters_array).to eq(expected_semesters_array)
    end

    it 'still creates all the years if the graduation semester is not Spring' do
      advisee = FactoryGirl.create(:advisee,
                                   graduation_semester: 'Fall',
                                   graduation_year: 2016)
      graduation_plan = FactoryGirl.create(:graduation_plan, advisee: advisee)

      created_semesters = graduation_plan.create_default_semesters
      created_semesters_array = reformat_semesters(created_semesters)

      expected_semesters_array = [
        'Remaining 1991',
        'Fall 2012',
        'Spring 2013',
        'Summer 2013',
        'Fall 2013',
        'Spring 2014',
        'Summer 2014',
        'Fall 2014',
        'Spring 2015',
        'Summer 2015',
        'Fall 2015',
        'Spring 2016',
        'Summer 2016',
        'Fall 2016'
      ]

      expect(created_semesters_array).to eq(expected_semesters_array)
    end
  end
end

def reformat_semesters(semesters)
  semesters.map do |semester|
    "#{semester.semester} #{semester.year}"
  end
end
