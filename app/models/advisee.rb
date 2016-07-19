class Advisee < ActiveRecord::Base
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                              message: 'That is not a valid email address' }
  validates :graduation_semester, presence: true,
                                  inclusion: { in: Semesters.all }
  validates :graduation_year, numericality: { only_integer: true,
                                              greater_than: 1990,
                                              less_than: 9999 }

  def self.all_for(user)
    Advisee.where(user: user)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
