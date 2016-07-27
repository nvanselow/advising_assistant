class Semester < ActiveRecord::Base
  belongs_to :graduation_plan
  has_many :courses, dependent: :destroy

  validates :semester, presence: true, inclusion: { in: Semesters.all }
  validates :year, presence: true, numericality: { only_integer: true,
                                                   greater_than: 1990,
                                                   less_than: 9999 }
  validates :graduation_plan, presence: true
end
