class Meeting < ActiveRecord::Base
  attr_writer :duration

  belongs_to :advisee

  validates :start_time, presence: true, timeliness: { before: :end_time }
  validates :end_time, presence: true, timeliness: { after: :start_time }
  validates :timezone, presence: true
  validates :advisee, presence: true

  def duration
    if(!start_time || !end_time)
      0
    else
      (end_time - start_time) / 60.to_f
    end
  end
end
