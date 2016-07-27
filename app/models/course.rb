class Course < ActiveRecord::Base
  belongs_to :semester

  validates :name, presence: true
  validates :semester, presence: true
end
