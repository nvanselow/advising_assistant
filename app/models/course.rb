class Course < ActiveRecord::Base
  belongs_to :semester

  validates :name, presence: true
  validates :semester, presence: true
  validates :credits,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
end
