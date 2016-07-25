class Meeting < ActiveRecord::Base
  attr_writer :duration

  belongs_to :advisee
  belongs_to :user
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

  def self.upcomming_for_user(user)
    where(user: user)
      .where('start_time > ?', Time.zone.now - 1.hour)
      .order(start_time: :desc)
      .limit(5)
  end

  def self.format_for_upcoming(meetings)
    meetings.map do |meeting|
      advisee = meeting.advisee

      {
        id: meeting.id,
        description: meeting.description,
        start_time: meeting.start_time,
        end_time: meeting.end_time,
        duration: meeting.duration,
        advisee: {
          id: advisee.id,
          full_name: advisee.full_name,
          first_name: advisee.first_name,
          last_name: advisee.last_name
        }
      }
    end
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
