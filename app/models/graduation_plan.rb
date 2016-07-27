class GraduationPlan < ActiveRecord::Base
  belongs_to :advisee
  has_many :semesters, dependent: :destroy

  validates :name, presence: true
  validates :advisee, presence: true

  def create_default_semesters
    years = 4

    final_semester = advisee.graduation_semester
    final_year = advisee.graduation_year

    beginning_semester = get_first_semester(final_semester)
    beginning_year = final_year.to_i - years

    semesters.create!(semester: 'Remaining', year: 1991, remaining_courses: true)

    years.times do |num|
      semesters.create!(semester: 'Fall', year: beginning_year + num)
      semesters.create!(semester: 'Spring', year: beginning_year + num + 1)
      semesters.create!(semester: 'Summer', year: beginning_year + num + 1)

      if num == 3 && final_semester == 'Fall'
        semesters.create!(semester: 'Fall', year: beginning_year + num + 1)
      end
    end

    semesters.order(:year)
  end

  private

  def get_first_semester(final_semester)
    final_semester_index = Semesters.all.find_index(final_semester)
    Semesters.all[final_semester_index - 1]
  end
end
