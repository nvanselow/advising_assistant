class GraduationPlan < ActiveRecord::Base
  belongs_to :advisee
  has_many :semesters

  validates :name, presence: true
  validates :advisee, presence: true
end
