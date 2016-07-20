class Note < ActiveRecord::Base
  belongs_to :noteable, polymorphic: true

  validates :body, presence: true
end
