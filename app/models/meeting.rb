class Meeting < ActiveRecord::Base
  attr_writer :duration

  belongs_to :advisee
  has_many :notes, as: :noteable, dependent: :destroy

  validates :start_time, presence: true, timeliness: true
  validates :end_time, presence: true, timeliness: true
  validates :advisee, presence: true

  def self.new_from_duration(params)
    meeting = Meeting.new(params)

    if params[:duration] && params[:duration] != '' && meeting.start_time
      meeting.end_time = meeting.start_time + params[:duration].to_i.minutes
    end

    meeting
  end

  def duration
    if !start_time || !end_time
      0
    else
      (end_time - start_time) / 60.to_f
    end
  end

  def formatted_time
    "#{start_time.strftime('%b %d, %Y from%l:%M %p')} to "\
                           "#{end_time.strftime('%l:%M %p')}"
  end

  def as_json(options = {})
    m = super(options)
    m[:duration] = duration
    m
  end
end
