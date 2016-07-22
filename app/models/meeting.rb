class Meeting < ActiveRecord::Base
  attr_writer :duration

  belongs_to :advisee

  validates :start_time, presence: true, timeliness: true
  validates :end_time, presence: true, timeliness: true
  validates :timezone, presence: true
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

  def as_json(options = {})
    m = super(options)
    m[:duration] = duration
    m
  end
end
