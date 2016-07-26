class GraduationPlan < ActiveRecord::Base
  belongs_to :advisee

  validates :name, presence: true
end
