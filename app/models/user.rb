class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :advisees, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :meetings, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def can_modify?(resource)
    id == resource.user_id
  end
end
