require 'digest/md5'

class Advisee < ActiveRecord::Base
  include PgSearch
  mount_uploader :photo, AdviseePhotoUploader

  belongs_to :user
  has_many :notes, as: :noteable, dependent: :destroy

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

  pg_search_scope :search_advisees,
                  against: [:first_name, :last_name, :email],
                  using: {
                    tsearch: { prefix: true }
                  }
  scope :search, -> (query) { search_advisees(query) if query.present? }

  def self.all_for(user)
    Advisee.where(user: user)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def photo_url
    if photo.to_s == ""
      "https://www.gravatar.com/avatar/#{email_hash}"
    else
      photo.to_s
    end
  end

  def as_json(options = {})
    h = super(options)
    h[:photo_url] = photo_url
    h
  end

  private

  def email_hash
    Digest::MD5.hexdigest(email)
  end
end
